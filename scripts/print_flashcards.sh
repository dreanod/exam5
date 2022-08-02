#!/bin/bash

echo "$1"
odd_split="$1-odd.pdf"
even_split="$1-even.pdf"

echo "$odd_split"

pdftk $1 cat 1-endodd output $odd_split
pdftk $1 cat 1-endeven output $even_split

neven=FC-01-Introduction.pdf-odd.pdf  dump_data | grep "NumberOfPages"
nleft=seq 3 3 $neven
ncenter=seq 2 3 $neven
nleft=seq 1 3 $neven

pdftk $1 cat 1-endeven output $even_split


#pdfjam --no-tidy --frame true --a4paper --nup 3x5 $odd_split --outfile $odd_split
#pdfjam --no-tidy --frame true --a4paper --nup 3x5 $even_split --outfile $even_split
