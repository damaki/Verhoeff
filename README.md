# Verhoeff

This project is a small library to compute
[Verhoeff](https://en.wikipedia.org/wiki/Verhoeff_algorithm) check digits.
It is written in the SPARK 2014 subset of the Ada 2012 programming language.

# License

This project is licensed under the MIT license. See the LICENSE file for more
information.

# Formal Verification

The source code for this library (verhoeff.ads and verhoeff.adb) is formally
verified to be free of runtime errors (e.g. out-of-bounds accesses to arrays,
integer overflows, etc...) using GNATprove.

The Verhoeff lookup tables used in the implementation are verified to have 
certain properties required by the Verhoeff algorithm, but the entire code is
not formally verified to correctly implement the algorithm. However, there are
some unit tests to provide assurance of the algorithm's correctness.

# Building

Building the library requires the [GNAT](http://libre.adacore.com/) toolset.

To build the library:
```
make build
```

To install the library to ``somedirectory``:
```
make install DESTDIR=somedirectory
```

To generate the proofs using GNATprove:
```
make proof
```

To run the unit tests:
```
make test
```

Alternatively, you can just copy the files ``src/verhoeff.ads`` and 
``src/verhoeff.adb`` into your project.
