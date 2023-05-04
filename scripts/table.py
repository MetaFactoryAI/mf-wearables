import os
import sys
import math
import subprocess
from pathlib import Path

def main():
    if len(sys.argv) < 2:
        print("Usage: python table.py directory/")
        sys.exit(1)

    directory = sys.argv[1]
    pairs = {}

    for root, dirs, files in os.walk(directory):
        for glb in files:
            if glb.endswith(".glb"):
                base = Path(glb).stem
                png = Path(root) / (base + ".png")
                if png.exists():
                    pairs[base] = (Path(root) / glb, png)

    count = len(pairs)
    size = int(math.sqrt(count))

    output = subprocess.check_output(['bash', 'scripts/table.sh', directory], universal_newlines=True)


    ## Change this later to be based on repo name
    print("# MF Wearables\n")
    print("Digital versions of physical merch sold on shop.metafactory.ai\n")
    print("\n")
    print("See tasks: https://app.dework.xyz/metafactory/metaverse\n")
    print("\n")
    print("<details>\n")
    print("<summary>View Checklist</summary>\n")
    #os.system('bash scripts/table.sh {}'.format(directory))
    print(output)
    print("</details>\n")
    print("\n")
    print(f" ## Progress {directory}")
    print("\n")

    print("|", end="")
    for i in range(size):
        print(f" {i + 1} |", end="")
    print()

    print("|", end="")
    for i in range(size):
        print(" --- |", end="")
    print()

    index = 0
    for key, value in pairs.items():
        if index % size == 0:
            print("|", end="")

        glb, png = value
        print(f" [![{key}]({png})]({glb}) |", end="")

        index += 1

        if index % size == 0:
            print()

    print()

if __name__ == "__main__":
    main()

