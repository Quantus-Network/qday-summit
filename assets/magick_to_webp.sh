#!/bin/bash

# Check if ImageMagick (magick) is installed
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick is not installed or 'magick' command is not in PATH."
    echo "Install it using: sudo apt install imagemagick (Ubuntu) or brew install imagemagick (macOS)"
    # Note: On some older v6 installs, the command is 'convert' instead of 'magick'
    exit 1
fi

count=0

# Loop through all PNG files
for file in *.png; do
    if [ -f "$file" ]; then
        # Extract filename without the .png extension
        filename="${file%.png}"
        
        echo "Converting: $file -> ${filename}.webp"
        
        # Use ImageMagick to convert and compress
        # -quality 80 reduces file size while maintaining great visual quality
        magick "$file" -quality 80 "${filename}.webp"
        
        count=$((count + 1))
    fi
done

if [ $count -eq 0 ]; then
    echo "No .png files found to convert."
else
    echo "Success! ImageMagick converted $count files to .webp."
fi