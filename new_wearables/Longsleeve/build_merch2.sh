#!/bin/bash

# Check for the input GLTF file argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_gltf_file>"
    exit 1
fi

input_gltf="$1"

# Find all PNG files in the current directory
png_files=($(find . -maxdepth 1 -type f -name "*.png"))

# Loop through the PNG files and process each one
for png_file in "${png_files[@]}"; do
    # Copy the input GLTF file to a new temporary file
    temp_gltf="temp_$input_gltf"
    cp "$input_gltf" "$temp_gltf"

    # Extract the PNG file name without the extension
    new_name=$(basename "$png_file" .png)

    # Replace the "name" and "uri" in the GLTF file
    sed -i "s|\"name\": \"Bake\"|\"name\": \"$new_name\"|" "$temp_gltf"
    sed -i "s|\"uri\": \"Bake.png\"|\"uri\": \"$png_file\"|" "$temp_gltf"

    # Rename the GLTF file with the name of the PNG file and a .gltf extension
    new_gltf="${new_name}.gltf"
    mv "$temp_gltf" "$new_gltf"

    # Run gltf-pipeline to convert the modified GLTF to GLB
    out_glb="${new_name}.glb"
    gltf-pipeline -i "$new_gltf" -b -o "$out_glb"

    echo "Processed $input_gltf with $png_file. Output: $out_glb"
done
