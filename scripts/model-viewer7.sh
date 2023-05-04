#!/bin/bash

# Check if HDR file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <HDR_FILE>"
  exit 1
fi

hdr_file=$1

# Loop through all GLB files in the current directory
for glb_file in *.glb; do
  # Remove file extension
  file_name=$(basename "$glb_file" .glb)

  # Create an HTML file for each GLB file
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
  <model-viewer src="${glb_file}" camera-controls auto-rotate touch-action="pan-y" skybox-image="${hdr_file}"></model-viewer>
</body>
</html>
EOL
done

