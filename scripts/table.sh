#!/bin/bash

echo "| Folder Name | PNG File | Apose GLB | Tpose GLB | GLB File |"
echo "| ---------- | -------- | --------- | --------- | -------- |"


for folder in $(find $1 -type d -name '[0-9]*' | sort -V); do
#for folder in $1/[0-9]*; do
  png_file=""
  apose_glb=""
  tpose_glb=""
  glb_file=""
  for file in "$folder"/*; do
    case "$file" in
      *.png)
        png_file=":heavy_check_mark:"
        ;;
      *_a.glb)
        apose_glb=":heavy_check_mark:"
        ;;
      *_t.glb)
        tpose_glb=":heavy_check_mark:"
        ;;
      *.glb)
        glb_file=":heavy_check_mark:"
        ;;
    esac
  done
  echo "| ${folder##*/} | $png_file | $apose_glb | $tpose_glb | $glb_file |"
done

## Calculate some stats
completed=$(dirname `find "$1" -iname "*.glb"` | uniq | wc -l)
total_folders=$(find $1 -type d | wc -l)
apose_count=$(find "$1" -iname "*_a.glb" | wc -l)
tpose_count=$(find "$1" -iname "*_t.glb" | wc -l)

percentage=$(echo "scale=2; $completed/$total_folders*100" | bc)
echo ""
echo ""
echo "- Folders with completed assets: $completed"
echo "- Total folders: $total_folders"
echo "- Percentage of folders with png and glb: $percentage%"
