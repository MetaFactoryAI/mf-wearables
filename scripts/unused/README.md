# Scripts


## `screenshots2.sh`

Usage: `/scripts/screenshot2.sh wearables`

Finds all glbs in `wearables/` directory recursively, checks if there's any new ones since last commit, then takes a screenshot if there are new ones using [screenshot-glb](https://github.com/Shopify/screenshot-glb).

## `generate_html_gallery.sh`

Usage: `./scripts/generate_html_gallery.sh wearables --head --body --tail > index.html`

- Prints HTML header with --head flag
- Generates HTML gallery with --body flag
- Closes HTML with --tail flag

## `table.py`

Usage: `python scripts/table.py wearables > README.md`

Updates the README by printing out some markdown and creates an optimal sized table based on the number of (glb) files to display
