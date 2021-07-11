#!/bin/sh

# linting language server
go get github.com/mattn/efm-langserver

# typescript language server
npm install -g typescript typescript-language-server eslint_d 

# clojure language server
# yay -s clojure-lsp-bin
