# udat.jl - Wrapper for ICU (International Components for Unicode) library

# Some content of the documentation strings was derived from the ICU header files udat.h
# (Those portions copyright (C) 1996-2015, International Business Machines Corporation and others)

"""
"""
module UDAT
const NONE     = Int32(-1)
const FULL     = Int32(0)
const LONG     = Int32(1)
const MEDIUM   = Int32(2)
const SHORT    = Int32(3)
const RELATIVE = Int32(128)
end # module UDAT

export UDAT, UDateFormat

macro libdat(s)     ; _libicu(s, iculibi18n, "udat_")     ; end

mutable struct UDateFormat
    ptr::Ptr{Cvoid}

    UDateFormat(tstyle::Integer, dstyle::Integer, tz::UniStr) =
        UDateFormat(tstyle, dstyle, Vector{UInt16}(tz))
    function UDateFormat(tstyle::Integer, dstyle::Integer, tz::Vector{UInt16})
        err = UErrorCode[0]
        p = ccall(@libdat(open), Ptr{Cvoid},
                  (Int32, Int32, Ptr{UInt8}, Ptr{UChar}, Int32,
                   Ptr{UChar}, Int32, Ptr{UErrorCode}),
                  tstyle, dstyle, locale[], tz, length(tz), C_NULL, 0, err)
        FAILURE(err[1]) && error("bad date format")
        self = new(p)
        finalizer(self, close)
        self
    end

    UDateFormat(pattern::UniStr, tz::UniStr) =
        UDateFormat(Vector{UInt16}(pattern), Vector{UInt16}(tz))
    function UDateFormat(pattern::Vector{UInt16}, tz::Vector{UInt16})
        err = UErrorCode[0]
        p = ccall(@libdat(open), Ptr{Cvoid},
                  (Int32, Int32, Ptr{UInt8}, Ptr{UChar}, Int32,
                   Ptr{UChar}, Int32, Ptr{UErrorCode}),
                  -2, -2, locale[], tz, length(tz),
                  pattern, length(pattern), err)
        FAILURE(err[1]) && error("bad date format")
        self = new(p)
        finalizer(self, close)
        self
    end
end

UDateFormat(pattern::AbstractString, tz::AbstractString) =
    UDateFormat(cvt_utf16(pattern), cvt_utf16(tz))

UDateFormat(tstyle::Integer, dstyle::Integer, tz::AbstractString) =
    UDateFormat(tstyle, dstyle, cvt_utf16(tz))

close(df::UDateFormat) =
    df.ptr == C_NULL || (ccall(@libdat(close), Cvoid, (Ptr{Cvoid},), df.ptr) ; df.ptr = C_NULL)

function format(df::UDateFormat, millis::Float64)
    err = UErrorCode[0]
    buflen = 64
    buf = zeros(UChar, buflen)
    len = ccall(@libdat(format), Int32,
                (Ptr{Cvoid}, Float64, Ptr{UChar}, Int32, Ptr{Cvoid}, Ptr{UErrorCode}),
                df.ptr, millis, buf, buflen, C_NULL, err)
    FAILURE(err[1]) && error("failed to format time")
    UniStr(buf[1:len+1])
end

parse(df::UDateFormat, s::AbstractString) = parse(df, cvt_utf16(s))
parse(df::UDateFormat, s::UniStr) = parse(df, Vector{UInt16}(s))
function parse(df::UDateFormat, s16::Vector{UInt16})
    err = UErrorCode[0]
    ret = ccall(@libdat(parse), Float64,
                (Ptr{Cvoid}, Ptr{UChar}, Int32, Ptr{Int32}, Ptr{UErrorCode}),
                df.ptr, s16, length(s16), C_NULL, err)
    FAILURE(err[1]) && error("failed to parse string")
    ret
end
