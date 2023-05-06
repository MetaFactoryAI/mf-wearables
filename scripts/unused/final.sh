#!/bin/bash

# After running setup.py you have a lot of pngs and glbs
# This script adds the original filenames to pngs
# It also cleans up the folder, deleting extra glbs
# -------------------------------------------------
# Move saved pngs into render folder before running
# -------------------------------------------------


# Check if the directory called "render" exists or if you're already in it
if [ -d "render" ]; then
  # If the directory exists or you're already in it, cd into it
  cd render
else
  # If the directory does not exist, exit the program and echo "render directory not found"
  echo "render directory not found"
  exit 1
fi


# Read each line of files.txt
while IFS=',' read -r col1 col2
do
  # Get the file extension
  ext="${col2##*.}"
  # Rename the file in column 2 to the value of column 1, keeping the file extension
  mv "front-$col1.png" "$(basename $col2 .glb).png"
  mv "back-$col1.png" "$(basename $col2 .glb).png"
  rm "$col1.glb"
done < files.txt


# Create a markdown table with info about assets
# -----------------------------------------------
# column 1 is the names of folders in current directory
# column 2 being if there's a png file and checkmark if true
# column 3 for detecting "apose" in filename for glbs and checkmark if true in each row
# column 4 is similar to column 3 but checks for "tpose" in glb filenames
# If neither apose or tpose check if generic glb (might be a hat or socks etc)

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
