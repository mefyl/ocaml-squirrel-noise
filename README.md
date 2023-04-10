# Squirrel Noise implementation in pure OCaml

[![OCaml-CI Build Status](https://img.shields.io/endpoint?url=https://ocaml.ci.dev/badge/mefyl/ocaml-squirrel-noise/master&logo=ocaml)](https://ocaml.ci.dev/github/mefyl/ocaml-squirrel-niose)

Implementation of the version 5 of the Squirrel noise function as
[introduced by Squirrel Eiserloh at GDC](https://youtu.be/LWFzPP8ZbdU).

## Conformance

Generated noise is checked against the [reference
implementation](http://eiserloh.net/noise/SquirrelNoise5.hpp) and
should be bit-for-bit equivalent, with the exception that returned
floating point numbers are double precision since OCaml only support
these.

## Implementation choice

This is a pure OCaml implementation and not stubs to the reference C
implementation so as to be platform agnostic - eg. targeting
js_of_ocaml.
