import sys
import bpy
import glob
import re

bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete()


## Use this if on a beefy PC and want to import EVERYTHING
#current_dir = sys.path[0]
#files = glob.glob(current_dir + '/**/*.glb', recursive=True)

files = glob.glob("*.glb")
files.sort(key=lambda f: int(re.sub('\D', '', f)))

row = 0
col = 0

for i, f in enumerate(files):
    bpy.ops.import_scene.gltf(filepath=f)
    bpy.context.active_object.location = (col*2, row*2, 0)
    bpy.context.active_object.name = f.split('.')[0]
    col += 1
    if col == 16:
        col = 0
        row += -1