#!/bin/bash
# usage: sh qacompile.sh (FILE without _ex.tex)
# The file you want to edit
# FILE="$1"
# FILEQ="${FILE%.tex}_q.tex"
# FILEA="${FILE%.tex}_a.tex"
RAWFILE="$1"
FILE="$1ex.tex"
FILEQ="${FILE%.tex}_q.tex"
FILEA="${FILE%.tex}_a.tex"

# comment out lines containing \ansdisplay: showing Q
sed 's/  \(\\ansdisplay\)/% \1/g' $FILE > $FILEQ
# compile the question file
latexmk -xelatex -jobname=${FILE%.tex}_Q $FILEQ
# uncomment lines containing \ansdisplay
sed 's/% \(\\ansdisplay\)/\1/g' $FILEQ > $FILEA
# compile the answer file
latexmk -xelatex -jobname=${FILE%.tex}_A "$FILEA"
# clean up
latexmk -c
rm $FILEQ $FILEA
