![](https://github.com/puripuri2100/csv2satyg/workflows/CI/badge.svg)


# csv2satyg

Converts xml file to SATySFi's package file.


# Install using OPAM

Here is a list of minimally required softwares.

* git
* make
* [opam](https://opam.ocaml.org/) 2.0
* ocaml (>= 4.06.0) (installed by OPAM)


## Example

### Install opam (Ubuntu)

```sh
sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)

eval $(opam env)
```

### Install ocaml (Ubuntu)

```sh
opam init --comp 4.07.1
```

### Install ocaml (Ubuntu on WSL)

```sh
opam init --comp 4.07.1 --disable-sandboxing
```

### Build

```sh
git clone https://github.com/puripuri2100/csv2satyg.git
cd csv2satyg

opam pin add csv2satyg .
opam install csv2satyg
```


# Usage of xml2saty

Type

```sh
csv2satyg <input file> -o <output file> -t <SATySFi type list>
```

## Starting out

```sh
make demo
```

If `demo/textcolor.satyg` and `demo/textcolor-t.satyg` are created, then the setup has been finished correctly.

---

This software released under [the MIT license](https://github.com/puripuri2100/csv2satyg/blob/master/LICENSE).

Copyright (c) 2020 Naoki Kaneko (a.k.a. "puripuri2100")