# StrICU: International Components for Unicode (ICU) wrapper for Julia
====================================================================

Julia wrapper for the
[International Components for Unicode (ICU) libraries](http://site.icu-project.org/).

[pkg-url]: https://github.com/JuliaString/StrICU.jl.git

[julia-url]:    https://github.com/JuliaLang/Julia
[julia-release]:https://img.shields.io/github/release/JuliaLang/julia.svg

[release]:      https://img.shields.io/github/release/JuliaString/StrICU.jl.svg
[release-date]: https://img.shields.io/github/release-date/JuliaString/StrICU.jl.svg
[checks]:       https://img.shields.io/github/checks-status/JuliaString/StrICU.jl/master

[license-img]:  http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]:  LICENSE.md

[gitter-img]:   https://badges.gitter.im/Join%20Chat.svg
[gitter-url]:   https://gitter.im/JuliaString/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

[codecov-url]:  https://codecov.io/gh/JuliaString/StrICU.jl
[codecov-img]:  https://codecov.io/gh/JuliaString/StrICU.jl/branch/master/graph/badge.svg

[contrib]:    https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat

[![][release]][pkg-url] [![][release-date]][pkg-url] [![][checks]][pkg-url] [![][codecov-img]][codecov-url] [![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/JuliaString/StrICU.jl/issues)

This is a new wrapper for the ICU library, designed to work on Julia v1.0 and above, using the [Strs.jl](http://github.com/JuliaString/Strs.jl) package to provide support for UTF-16 encoded strings.
The API has been redesigned to not pollute the namespace and to try to be a bit more "Julian"
