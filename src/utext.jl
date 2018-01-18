# utext.jl - Wrapper for ICU (International Components for Unicode) library

# Some content of the documentation strings was derived from the ICU header files utext.h
# (Those portions copyright (C) 1996-2015, International Business Machines Corporation and others)

"""
"""
module utext end

macro libtext(s)    ; _libicu(s, iculib,     "utext_")    ; end

mutable struct UText
    p::Ptr{Void}
    s

    function UText(str::ByteStr)
        err = UErrorCode[0]
        v = convert(UTF8Str, str)
        p = ccall(@libtext(openUTF8), Ptr{Void},
                  (Ptr{Void}, Ptr{UInt8}, Int64, Ptr{UErrorCode}),
                  C_NULL, v, sizeof(v), err)
        @assert SUCCESS(err[1])
        # Retain pointer to data so that it won't be GCed
        self = new(p, v)
        finalizer(self, close)
        self
    end

    function UText(str::UTF16Str)
        err = UErrorCode[0]
        p = ccall(@libtext(openUChars), Ptr{Void},
                  (Ptr{Void}, Ptr{UChar}, Int64, Ptr{UErrorCode}),
                  C_NULL, pointer(str), ncodeunits(str), err)
        @assert SUCCESS(err[1])
        # Retain pointer to data so that it won't be GCed
        self = new(p, str)
        finalizer(self, close)
        self
    end
end

close(t::UText) =
    t.p == C_NULL ||
        (ccall(@libtext(close), Void, (Ptr{Void},), t.p) ; t.p = C_NULL ; t.s = Void())
