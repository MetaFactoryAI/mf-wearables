#!/bin/bash

# Find all glbs recursively and cp to folder called render, renaming each glb with a prefix then underscore of the folder it was copied from

echo "Run this script in the root directory of where all the glbs are"
echo "Checking..."

# Check if any glbs exist recursively in directory
if find . -name "*.glb" -exec false {} +; then
    echo "No glbs found"
    exit 0
else
    echo "Glbs found"
fi

# Set the source directory
src_dir="."

# Set the destination directory
dest_dir="render"

# Create the destination directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
    mkdir "$dest_dir"
fi

echo "Setting up render folder with assets"

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

# Create text file that holds filename scheme
cd "$dest_dir"
ls -v *.glb > glb.txt
nl -s "," -w 1 glb.txt > files.txt
numFiles="$(cat files.txt | wc -l)"
srcFiles="$(head -n 1 glb.txt)"

# Read each line of files.txt (separated by comma)
while IFS=',' read -r col1 col2
do
  # Get the file extension
  ext="${col2##*.}"
  # Rename the file in column 2 to the value of column 1, keeping the file extension
  mv "$col2" "$col1.$ext"
done < files.txt

cat <<EOF > back.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB Viewer</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="140deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> back.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `back-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > front.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB Viewer</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="320deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> front.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `front-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > 0.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB Viewer</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="0deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 0.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `0-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > 1.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 1</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="45deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 1.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `1-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > 2.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 2</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="90deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 2.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `2-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > 3.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 3</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="135deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 3.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `3-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF


cat <<EOF > 4.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 4</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="180deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 4.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `4-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF

cat <<EOF > 5.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 5</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="225deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 5.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `5-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF

cat <<EOF > 6.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 6</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="270deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 6.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `6-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF

cat <<EOF > 7.html
<html>
  <head>
    <meta charset="UTF-8" />
    <title>GLB 7</title>
    <script
      type="module"
      src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"
    ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  </head>
  <body>
    <model-viewer
      id="toggle-model"
      src="$srcFiles"
      alt="Voxel Assets"
      shadow-intensity="1"
      camera-controls
      touch-action="pan-y"
      style="width: 100%; height: 100%;"
      camera-orbit="315deg 90deg 4m"></model-viewer>
    <script>
      const toggleModel = document.querySelector("#toggle-model");

      const numItems = $numFiles;
EOF

cat <<\EOF >> 7.html
      const saveGLTFasImage = async () => {
        for (let i = 1; i < numItems + 1; i++) {
          toggleModel.setAttribute("src", `${i}.glb`);
          await sleep(1000);
          const myBlob = await toggleModel.toBlob();
          saveAs(myBlob, `7-${i}.png`);
        }
      };

      // // non blocking sleep function
      const sleep = (ms) => {
        return new Promise((resolve) => setTimeout(resolve, ms));
      };

      // Start the cycle
      saveGLTFasImage();
    </script>
  </body>
</html>
EOF

# Make an index
tree -H . > index.html

echo "...."
echo "Ready to thumbnail"
echo "Recommended to use Chromium for next step"
echo ""
echo "Do you want to start a python web server? (Y/N)"
read answer

if [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then

    # Start python3 http.server at port 9000
    python3 -m http.server 9000 &
    
    # Open chromium-browser
    chromium-browser --window-size=528,662 http://localhost:9000/front.html
    
    # Wait for chromium-browser to close
    wait
    
    # Turn the http.server off
    kill $(jobs -p)

    echo ""
    echo ""
    echo "Reminder to run finish.sh to update the progress table"
    echo "You can tweak the index.html and re-render as much as you like"
elif [ "$answer" == "N" ] || [ "$answer" == "n" ]; then
    exit 0
else
    echo "Invalid input. Exiting program."
    exit 1
fi
