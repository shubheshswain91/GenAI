#!/bin/bash

# 1. Create the directory if it doesn't exist
mkdir -p images

# 2. Move images to the folder
# Handle the base image.png
if [ -f "image.png" ]; then
    mv image.png images/
    echo "Moved image.png to images/"
fi

# Handle the incremental image-*.png files
if ls image-*.png 1> /dev/null 2>&1; then
    mv image-*.png images/
    echo "Moved incremental images to images/"
fi

# 3. Update the README.md file
# We use two separate sed commands to ensure accuracy.
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS Version
    # First: Replace image.png (using a word boundary to avoid matching image-1)
    sed -i '' 's|!\[alt text\](image.png)|![alt text](images/image.png)|g' README.md
    # Second: Replace the incremental pattern image-
    sed -i '' 's|!\[alt text\](image-|![alt text](images/image-|g' README.md
else
    # Linux/GNU Version
    sed -i 's|!\[alt text\](image.png)|![alt text](images/image.png)|g' README.md
    sed -i 's|!\[alt text\](image-|![alt text](images/image-|g' README.md
fi

echo "README.md references updated successfully."