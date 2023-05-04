#!/bin/bash

shopt -s globstar nullglob

for file in **/*.glb; do
  if [[ -f "${file}" ]]; then
    dir=$(dirname "${file}")
    filename=$(basename "${file}")
    ext="${filename##*.}"
    filename="${filename%.*}"
    
    if [[ $filename == *"apose"* ]]; then
      filename="${filename/_apose/}_a"
    elif [[ $filename == *"tpose"* ]]; then
      filename="${filename/_tpose/}_t"
    fi
    
    mv "$file" "$dir/${dir##*/}_${filename}.${ext}"
  fi
done
