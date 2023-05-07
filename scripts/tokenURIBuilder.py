import json

# The name of file to save all tokenURIs to
output_file = 'tokenURIs.json'
# Data dump from MF OS
input_file = 'metadata.json'

# read in the input JSON file
with open(input_file, 'r') as f:
    data = json.load(f)

# loop through each item in the JSON file and format it according to your specified format
formatted_data = []
for item in data:
    formatted_item = {
        "name": item["name"],
        "description": item["description"],
        "image": "",
        "external_url": "",
        "animation_url": "",
        "properties": {
            "brand": "",
            "rarity": "",
            "season": "",
            "style": "",
            "material": "",
            "manufactured_in": "",
            "designers": [],
            "models": []
        }
    }
    formatted_data.append(formatted_item)

# write the formatted JSON data to the output file
with open(output_file, 'w') as f:
    json.dump(formatted_data, f, indent=2)
