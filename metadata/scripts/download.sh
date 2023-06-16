#!/bin/bash

# Define the URL pattern
URL_PATTERN="https://beta.mf.app/api/nftMetadata/"

# Read each line from ids.txt and process
while IFS= read -r number; do
    # Construct the complete URL for the current number
    url="${URL_PATTERN}${number}"

    # Download the JSON data using wget
    wget -O "${number}.json" "$url"

    # Optional: Add a delay between each download to avoid overwhelming the server
    sleep 1

done < "ids.txt"
