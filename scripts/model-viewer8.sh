#!/bin/bash

# Check if HDR file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <HDR_FILE>"
  exit 1
fi

folder="wearables"
hdr_file=$1
skybox_file=$2

# Loop through all directories in the current directory
for dir in "$folder"/*; do
  # Check if directory contains any GLB files
  if [ "$(find "${dir}" -maxdepth 1 -type f -iname "*.glb" | wc -l)" -eq 0 ]; then
    continue
  fi

  # Get number of GLB files in the directory
  glb_count=$(find "${dir}" -maxdepth 1 -type f -iname "*.glb" | wc -l)

  # Loop through all GLB files in the directory
  i=0
  for glb_file in "${dir}"/*.glb; do
    # Check if file name ends with "_t.glb"
    if [[ "${glb_file}" == "*_t.glb" ]]; then
      continue
    fi

    # Increment file counter
    ((i++))

    # Remove file extension and append file counter to directory name if there's more than 1 GLB file
    file_name=$(basename "${glb_file}" .glb)
    glb=$(basename "${glb_file}")
    if [ "${glb_count}" -gt 1 ] && [[ "${glb_file}" == "*_t.glb" ]]; then
      file_name="${dir%/}_${i}"
    else
      file_name="${dir%/}"
    fi

    # Create an HTML file for the GLB file
    cat > "${file_name}.html" << EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${file_name}</title>
  <!-- Import the component -->
  <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.0.1/model-viewer.min.js"></script>
  <style>
    html, body {
      margin: 0;
      height: 100%;
    }
    model-viewer {
      width: 100%;
      height: 100%;
      display: block;
    }
    .buttons {
      position: absolute;
      top: 10px;
      right: 10px;
      z-index: 1;
    }
  </style>
</head>
<body>
  <div class="buttons">
    <button onclick="document.querySelector('model-viewer').enterFullscreen()">Enter VR</button>
    <button onclick="document.querySelector('model-viewer').exitFullscreen()">Exit VR</button>
    <button onclick="document.querySelector('model-viewer').ar.activate()">AR Mode</button>
  </div>
  <model-viewer src="${glb}" camera-controls auto-rotate touch-action="pan-y" skybox-image="../${skybox_file}" environment-image="../${hdr_file}"></model-viewer>
</body>
</html>
EOL

    # Move the generated HTML file into the directory
    mv "${file_name}.html" "${dir}"
  done
done

