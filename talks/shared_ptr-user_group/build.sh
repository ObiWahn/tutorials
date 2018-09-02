#!/bin/bash

file=talk

build(){
./wiki2beamer "${file}_wiki" > "${file}_wiki.tex" || { echo "wiki2beamer failed"; exit 1; }

pdflatex "$file" && bibtex "$file" && pdflatex "$file" && pdflatex "$file"
## pdflatex "$file"
## bibtex "$file"
## pdflatex "$file"
## pdflatex "$file"
}

clean(){
    rm $file.{aux,blg,bbl,log,snm,toc,out,nav,vrb}
}

case "$1" in
    all)
       build
       clean
    ;;
    clean|c)
       clean
    ;;
    *)
       build
       clean
    ;;
esac
