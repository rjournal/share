#!/bin/bash
set -e

# Update style file
latex RJournal.ins

# Build all tests

cd tests/
rm -f *.png

latexmk -pdf -quiet *.tex

convert test-text.pdf -alpha remove test-test%02d.png
convert test-misc.pdf -alpha remove test-misc%02d.png
convert test-many-authors.pdf -alpha remove test-many-authors%02d.png

pngcrush -ow -q *.png

rm -f *.{aux,fls,.fdb_latexmk}
