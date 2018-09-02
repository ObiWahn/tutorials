#!/bin/bash

file=CMake_Talk

build(){
./wiki2beamer "${file}Wiki" > "${file}Wiki.tex" || { echo "wiki2beamer failed"; exit 1; }


#bash -e
pdflatex $file
bibtex   $file
pdflatex $file
pdflatex $file
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
