#!/bin/bash

# Get the commit hash of the last Git commit
last_commit=$(git rev-parse HEAD)

# Find all .glb files in the wearables/ directory and its subdirectories
glb_files=$(find "$1" -name "*.glb")

# Loop through each .glb file and check if it has been added or modified since the last commit
for glb_file in $glb_files; do
    # Get the filename without the extension
    filename=$(basename "$glb_file" .glb)
    
    # Get the folder path for the .glb file
    folder=$(dirname "$glb_file")

    # Check if the file has been added or modified since the last commit
    # if git diff --name-only --diff-filter=AM "$last_commit" HEAD -- "$glb_file" | grep -q "$glb_file"; then
        # Take the screenshot
      if node ./node_modules/.bin/screenshot-glb -i "$glb_file" -w 512 -h 512 -m "orientation=0 0 120" -o "$folder/$filename.png"; then
          echo "Screenshot of $glb_file saved as $folder/$filename.png"
      else
          echo "Failed to take screenshot of $glb_file"
      fi
    #fi
done

