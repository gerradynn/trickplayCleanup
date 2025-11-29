#!/bin/bash

# Define common media file extensions (add or remove as needed)
MEDIA_EXTENSIONS=("mkv" "mp4" "avi" "mov" "wmv" "flv")

# Check if a media file exists corresponding to a given trickplay folder name
file_exists() {
    local base_name="$1"
    
    # 2. Iterate through expected media extensions to see if a file exists
    for ext in "${MEDIA_EXTENSIONS[@]}"; do
        if [[ -f "${base_name}.${ext}" ]]; then
            return 0 # File exists
        fi
    done
    return 1 # File does not exist
}

# 1. Check if a directory path was provided as an argument
if [ -z "$1" ]; then
    echo "Error: Please provide the path to the media directory."
    echo "Usage: $0 /path/to/your/media/directory"
    exit 1
fi

# Set the input argument as the root directory
MEDIA_ROOT="$1"

# 2. Check if the provided path is a valid directory
if [ ! -d "$MEDIA_ROOT" ]; then
    echo "Error: Directory not found or is not a valid directory: $MEDIA_ROOT"
    exit 1
fi

echo "Starting trickplay cleanup in: **${MEDIA_ROOT}**"
echo "----------------------------------------------------"

# Find all items ending in '.trickplay' that are directories
find "$MEDIA_ROOT" -type d -name "*.trickplay" | while IFS= read -r trickplay_path; do
    
    # Extract the directory and the trickplay folder name
    dir_name=$(dirname "$trickplay_path")
    folder_name=$(basename "$trickplay_path")
    
    # Remove the ".trickplay" suffix to get the base file name
    base_name="${folder_name%.trickplay}"
    
    # Change into the directory containing the trickplay folder for easier checking
    pushd "$dir_name" > /dev/null
    
    if file_exists "$base_name"; then
        # TRICKPLAY IS VALID: An associated media file was found
        echo "Keeping: ${folder_name}"
    else
        # TRICKPLAY IS INVALID: No associated media file was found
        echo "Deleting: ${folder_name}"
        
        # Uncomment the next line to enable actual deletion.
        # **TEST THIS SCRIPT THOROUGHLY BEFORE UNCOMMENTING**
        # rm -rf "$folder_name" 
        
    fi
    
    # Return to the original directory
    popd > /dev/null

done

echo "----------------------------------------------------"
echo "Cleanup complete. Review output for confirmation."
