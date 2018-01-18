# ucal.jl - Wrapper for ICU (International Components for Unicode) library

# Some content of the documentation strings was derived from the ICU header files ucal.h
# (Those portions copyright (C) 1996-2015, International Business Machines Corporation and others)

export UCAL

"""
Defines the following constants for ICU Calendar functions (not exported):
ERA, YEAR, MONTH, WEEK_OF_YEAR, WEEK_OF_MONTH,
DATE, DAY_OF_YEAR, DAY_OF_WEEK, DAY_OF_WEEK_IN_MONTH,
AM_PM, HOUR, HOUR_OF_DAY, MINUTE, SECOND, MILLISECOND,
ZONE_OFFSET, DST_OFFSET, YEAR_WOY, DOW_LOCAL, EXTENDED_YEAR,
JULIAN_DAY, MILLISECONDS_IN_DAY, IS_LEAP_MONTH
"""
module UCAL
for (i,a) in enumerate([
        :ERA,
        :YEAR,
        :MONTH,
        :WEEK_OF_YEAR,
        :WEEK_OF_MONTH,
        :DATE,
        :DAY_OF_YEAR,
        :DAY_OF_WEEK,
        :DAY_OF_WEEK_IN_MONTH,
        :AM_PM,
        :HOUR,
        :HOUR_OF_DAY,
        :MINUTE,
        :SECOND,
        :MILLISECOND,
        :ZONE_OFFSET,
        :DST_OFFSET,
        :YEAR_WOY,
        :DOW_LOCAL,
        :EXTENDED_YEAR,
        :JULIAN_DAY,
        :MILLISECONDS_IN_DAY,
        :IS_LEAP_MONTH
    ])
    @eval const $a = Int32($i - 1)
end
end # module UCAL

const UDate = Float64

macro libcal(s)     ; _libicu(s, iculibi18n, "ucal_")     ; end

export UCalendar
mutable struct UCalendar
    ptr::Ptr{Cvoid}

    UCalendar(tz::UTF16Str) = UCalendar(Vector{UInt16}(tz))
    function UCalendar(tz::Vector{UInt16})
        err = UErrorCode[0]
        p = ccall(@libcal(open), Ptr{Cvoid},
                  (Ptr{UChar}, Int32, Ptr{UInt8}, Int32, Ptr{UErrorCode}),
                  tz, length(tz), locale[], 0, err)
        self = new(p)
        finalizer(self, close)
        self
    end
    function UCalendar()
        err = UErrorCode[0]
        p = ccall(@libcal(open), Ptr{Cvoid},
                  (Ptr{UChar}, Int32, Ptr{UInt8}, Int32, Ptr{UErrorCode}),
                  C_NULL, 0, locale[], 0, err)
        self = new(p)
        finalizer(self, close)
        self
    end
end

UCalendar(timezone::AbstractString) = UCalendar(cvt_utf16(timezone))

close(c::UCalendar) =
    c.ptr == C_NULL || (ccall(@libcal(close), Cvoid, (Ptr{Cvoid},), c.ptr) ; c.ptr = C_NULL)

getnow() = ccall(@libcal(getNow), UDate, ())

function get_millis(cal::UCalendar)
    err = UErrorCode[0]
    ccall(@libcal(getMillis), UDate, (Ptr{Cvoid}, Ptr{UErrorCode}), cal.ptr, err)
end

function set_millis!(cal::UCalendar, millis::UDate)
    err = UErrorCode[0]
    ccall(@libcal(setMillis), Cvoid,
          (Ptr{Cvoid}, UDate, Ptr{UErrorCode}),
          cal.ptr, millis, err)
end

function set_date!(cal::UCalendar, y::Integer, m::Integer, d::Integer)
    err = UErrorCode[0]
    ccall(@libcal(setDate), Cvoid,
          (Ptr{Cvoid}, Int32, Int32, Int32, Ptr{UErrorCode}),
          cal.ptr, y, m-1, d, err)
end

function set_datetime!(cal::UCalendar, y::Integer, mo::Integer, d::Integer,
                     h::Integer, mi::Integer, s::Integer)
    err = UErrorCode[0]
    ccall(@libcal(setDateTime), Cvoid,
          (Ptr{Cvoid}, Int32, Int32, Int32, Int32, Int32, Int32, Ptr{UErrorCode}),
          cal.ptr, y, mo-1, d, h, mi, s, err)
end

function clear!(cal::UCalendar)
    err = UErrorCode[0]
    ccall(@libcal(clear), Cvoid,
          (Ptr{Cvoid}, Ptr{UErrorCode}),
          cal.ptr, err)
end

function get(cal::UCalendar, field::Int32)
    err = UErrorCode[0]
    ccall(@libcal(get), Int32,
          (Ptr{Cvoid},Int32,Ptr{UErrorCode}),
          cal.ptr, field, err)
end
get(cal::UCalendar, fields::Vector{Int32}) = [get(cal,f) for f in fields]

function add!(cal::UCalendar, field::Int32, amount::Integer)
    err = UErrorCode[0]
    ccall(@libcal(add), Int32,
          (Ptr{Cvoid},Int32,Int32,Ptr{UErrorCode}),
          cal.ptr, field, amount, err)
end

set!(cal::UCalendar, field::Int32, val::Integer) =
    ccall(@libcal(set), Cvoid, (Ptr{Cvoid}, Int32, Int32), cal.ptr, field, val)

function get_timezone_displayname(cal::UCalendar)
    bufsz = 64
    buf = zeros(UInt16, bufsz)
    err = UErrorCode[0]
    len = ccall(@libcal(getTimeZoneDisplayName), Int32,
                (Ptr{Cvoid}, Int32, Ptr{UInt8}, Ptr{UChar}, Int32, Ptr{UErrorCode}),
                cal.ptr, 1, locale[], buf, bufsz, err)
    UTF16Str(buf[1:len])
end

function get_default_timezone()
    bufsz = 64
    buf = zeros(UInt16, bufsz)
    err = UErrorCode[0]
    len = ccall(@libcal(getDefaultTimeZone), Int32,
                (Ptr{UChar}, Int32, Ptr{UErrorCode}),
                buf, bufsz, err)
    UTF16Str(buf[1:len])
end
