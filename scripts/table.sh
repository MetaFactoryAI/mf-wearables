#!/bin/bash

# Create a markdown table with rows of the first column being the names of folders in current directory, column 2 being if there's a png file and checkmark if true, column 3 for detecting "apose" in filename for glbs and checkmark if true in each row, column 4 is similar to column 3 but checks for "tpose" in glb filenames, then if neither apose or tpose check if generic glb (might be a hat or socks etc)

echo "| Folder Name | PNG File | Apose GLB | Tpose GLB | GLB File |"
echo "| ---------- | -------- | --------- | --------- | -------- |"

total_folders=0
folders_with_png_and_glb=0

for folder in $(ls -v); do
  if [ -d "$folder" ] && [[ $folder =~ ^[0-9]+$ ]]; then
    png_file=""
    apose_glb=""
    tpose_glb=""
    glb_file=""
    for file in "$folder"/*; do
      case "$file" in
        *.png)
          png_file=":heavy_check_mark:"
          ;;
        *apose*.glb)
          apose_glb=":heavy_check_mark:"
          ;;
        *tpose*.glb)
          tpose_glb=":heavy_check_mark:"
          ;;
        *.glb)
          glb_file=":heavy_check_mark:"
          ;;
      esac
    done
    echo "| $folder | $png_file | $apose_glb | $tpose_glb | $glb_file |"
    total_folders=$((total_folders+1))
    if [[ $png_file == ":heavy_check_mark:" ]] && [[ $glb_file == ":heavy_check_mark:" ]] || [[ $apose_glb == ":heavy_check_mark:" ]] && [[ $tpose_glb == ":heavy_check_mark:" ]]; then
      folders_with_png_and_glb=$((folders_with_png_and_glb+1))
    fi
  fi
done

percentage=$(echo "scale=2; $folders_with_png_and_glb/$total_folders*100" | bc)
echo ""
echo ""
echo "- Folders with png and glb: $folders_with_png_and_glb"
echo "- Total folders: $total_folders"
echo "- Percentage of folders with png and glb: $percentage%"
