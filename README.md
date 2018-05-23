StrICU: International Components for Unicode (ICU) wrapper for Julia
====================================================================

Julia wrapper for the
[International Components for Unicode (ICU) libraries](http://site.icu-project.org/).

| **Package Status** | **Package Evaluator** | **Coverage**      |
|:------------------:|:---------------------:|:-----------------:|
| [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md) | [![StrICU](http://pkg.julialang.org/badges/StrICU_0.6.svg)](http://pkg.julialang.org/?pkg=StrICU) | [![Coverage Status](https://coveralls.io/repos/github/JuliaString/StrICU.jl/badge.svg?branch=master)](https://coveralls.io/github/JuliaString/StrICU.jl?branch=master) |
|  [![Build Status](https://travis-ci.org/JuliaString/StrICU.jl.svg?branch=master)](https://travis-ci.org/JuliaString/StrICU.jl) | [![StrICU](http://pkg.julialang.org/badges/StrICU_0.7.svg)](http://pkg.julialang.org/?pkg=StrICU)| [![codecov.io](http://codecov.io/github/JuliaString/StrICU.jl/coverage.svg?branch=master)](http://codecov.io/github/JuliaString/StrICU.jl?branch=master) |

This is a new wrapper for the ICU library, designed to work on Julia v0.6 and above,
using the [Strs.jl](http://github.com/JuliaString/Strs.jl) package.
The API has been redesigned to not pollute the namespace and to try to be a bit more "Julian"
