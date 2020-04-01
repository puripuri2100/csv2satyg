BUILD=_build
TARGET=csv2satyg
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

.PHONY: build install uninstall test demo

build: src
	-mkdir ${BUILD}
	cp src/lex.mll ${BUILD}
	cp src/parse.mly ${BUILD}
	cp src/*.ml src/*.mli ${BUILD}
	cd ${BUILD} && ocamllex lex.mll
	cd ${BUILD} && menhir parse.mly
	cd ${BUILD} && ocamlfind ocamlopt -o ${TARGET} -linkpkg -package "csv,str" range.ml error.ml types.ml parse.mli parse.ml lex.ml optionState.mli optionState.ml showSATySFiType.ml main.ml
	cp ${BUILD}/${TARGET} ./

install: ${TARGET}
	mkdir -p $(BINDIR)
	install $(TARGET) $(BINDIR)

uninstall:
	rm -rf $(BINDIR)/$(TARGET)

clean:
	rm -rf ${BUILD}
	rm -rf ${TARGET}

demo:
	${TARGET} -f test/textcolor.csv -o test/textcolor.satyg
	${TARGET} -f test/textcolor.csv -o test/textcolor-t.satyg -t "[function;string]" -r "color"

test:
	./${TARGET} -f test/textcolor.csv -o test/textcolor.satyg
	./${TARGET} -f test/textcolor.csv -o test/textcolor-t.satyg -t "[function;string]" -r "color"
