#!/bin/bash

# Find all .glb files in the wearables/ directory and its subdirectories
glb_files=$(find ./wearables -name "*.glb")

# Loop through each .glb file and take a screenshot
for glb_file in $glb_files; do
    # Get the filename without the extension
    filename=$(basename "$glb_file" .glb)
    
    # Get the folder path for the .glb file
    folder=$(dirname "$glb_file")

    # Take the screenshot
    if node ./node_modules/.bin/screenshot-glb -i "$glb_file" -w 512 -h 512 -m "orientation=0 0 120" -o "$folder/$filename.png"; then
        echo "Screenshot of $glb_file saved as $folder/$filename.png"
    else
        echo "Failed to take screenshot of $glb_file"
    fi
done

