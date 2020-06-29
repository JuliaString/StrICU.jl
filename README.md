# StrICU: International Components for Unicode (ICU) wrapper for Julia
====================================================================

Julia wrapper for the
[International Components for Unicode (ICU) libraries](http://site.icu-project.org/).

[pkg-url]: https://github.com/JuliaString/StrICU.jl.git

[julia-url]:    https://github.com/JuliaLang/Julia
[julia-release]:https://img.shields.io/github/release/JuliaLang/julia.svg

[release]:      https://img.shields.io/github/release/JuliaString/StrICU.jl.svg
[release-date]: https://img.shields.io/github/release-date/JuliaString/StrICU.jl.svg

[license-img]:  http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]:  LICENSE.md

[gitter-img]:   https://badges.gitter.im/Join%20Chat.svg
[gitter-url]:   https://gitter.im/JuliaString/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

[travis-url]:   https://travis-ci.org/JuliaString/StrICU.jl
[travis-s-img]: https://travis-ci.org/JuliaString/StrICU.jl.svg
[travis-m-img]: https://travis-ci.org/JuliaString/StrICU.jl.svg?branch=master

[codecov-url]:  https://codecov.io/gh/JuliaString/StrICU.jl
[codecov-img]:  https://codecov.io/gh/JuliaString/StrICU.jl/branch/master/graph/badge.svg

[contrib]:    https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat

[![][release]][pkg-url] [![][release-date]][pkg-url] [![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/JuliaString/StrICU.jl/issues)

| **Julia Version** | **Unit Tests** | **Coverage** |
|:------------------:|:------------------:|:---------------------:|
| [![][julia-release]][julia-url] | [![][travis-s-img]][travis-url] | [![][codecov-img]][codecov-url]
| Julia Latest | [![][travis-m-img]][travis-url] | [![][codecov-img]][codecov-url]

This is a new wrapper for the ICU library, designed to work on Julia v0.6 and above,
using the [Strs.jl](http://github.com/JuliaString/Strs.jl) package to provide support for UTF-16 encoded strings.
The API has been redesigned to not pollute the namespace and to try to be a bit more "Julian"
