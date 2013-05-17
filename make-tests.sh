#!/bin/bash
set -e

# Update style file
latex RJournal.ins

# Build all tests

cd tests/
pdflatex test-text.tex
convert test-text.pdf -alpha remove test-test%02d.png

pdflatex test-misc.tex
convert test-misc.pdf -alpha remove test-misc%02d.png

pdflatex test-many-authors.tex
convert test-many-authors.pdf -alpha remove test-many-authors%02d.png

rm *.{aux}
