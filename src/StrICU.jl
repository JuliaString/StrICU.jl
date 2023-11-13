# StrICU.jl - Wrapper for ICU (International Components for Unicode) library

# Some content of the documentation strings was derived from the ICU header files.
# (Those portions copyright (C) 1996-2015, International Business Machines Corporation and others)

"""
    StrICU (International Components for Unicode) Wrapper
"""
module StrICU

using ModuleInterfaceTools

using ICU_jll

# for now, just leave this hardcoded, until I can see how to get the version from ICU_jll
const suffix = "_74"
const iculib = ICU_jll.libicuuc
const iculibi18n = ICU_jll.libicui18n

@api extend! StrBase

finalizer(o, f::Function) = Base.finalizer(f, o)

import Base: parse, get, close

export ICU
const ICU = StrICU

const cvt_utf8 = utf8
const cvt_utf16 = utf16
export cvt_utf8, cvt_utf16

const ByteStr   = Union{ASCIIStr, UTF8Str, String}

const WordStringCSE = Union{UCS2CSE, _UCS2CSE, UTF16CSE}
const WordStrings = Str{<:WordStringCSE}

export set_locale!

function __init__()
    set_locale!("")
end

_libicu(s, lib, p) = ( Symbol(string(p, s, suffix)), lib )

const UBool      = Int8
const UChar      = UInt16
const UErrorCode = Int32
const U_PARSE_CONTEXT_LEN = 16
const U_PARSE_TUPLE = ntuple((i)->0x20, U_PARSE_CONTEXT_LEN)

struct UParseError
    line::UErrorCode                                 # The line on which the error occured
    offset::UErrorCode                               # The character offset to the error
    preContext::NTuple{U_PARSE_CONTEXT_LEN, UInt8}   # Textual context before the error
    postContext::NTuple{U_PARSE_CONTEXT_LEN, UInt8}  # The error itself and/or textual context after the error
end
UParseError() = UParseError(0, 0, U_PARSE_TUPLE, U_PARSE_TUPLE)

FAILURE(x::Integer) = x > 0
SUCCESS(x::Integer) = x <= 0
U_BUFFER_OVERFLOW_ERROR = 15

const locale   = ASCIIStr[""]

include("utext.jl")
include("ustring.jl")
include("ubrk.jl")
include("ucnv.jl")
include("ucol.jl")
include("ucsdet.jl")
include("udat.jl")
include("ucal.jl")
include("ucasemap.jl")

@api freeze

end # module StrICU
