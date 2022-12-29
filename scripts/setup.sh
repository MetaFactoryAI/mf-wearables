#!/bin/bash

# Find all glbs recursively and cp to folder called render, renaming each glb with a prefix then underscore of the folder it was copied from

# Set the source directory
src_dir="."

# Set the destination directory
dest_dir="render"

# Create the destination directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
    mkdir "$dest_dir"
fi

# Find all glbs recursively
find "$src_dir" -type f -name "*.glb" | while read glb_file; do
    # Get the directory name of the glb file
    dir_name=$(dirname "$glb_file")
    # Get the base name of the glb file
    base_name=$(basename "$glb_file")
    # Create the new file name
    new_name="$dir_name"_"$base_name"
    # Copy the glb file to the destination directory
    cp "$glb_file" "$dest_dir/$new_name"
done