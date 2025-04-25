#!/bin/bash
#
# Generate favicons from SVG file

# Requirements: ImageMagick, rsvg-convert (librsvg)
# Install on Ubuntu: sudo apt-get install imagemagick librsvg2-bin
# Install on macOS with Homebrew: brew install imagemagick librsvg

# Check if required commands exist
for cmd in convert rsvg-convert; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed."
    echo "Please install ImageMagick and librsvg."
    exit 1
  fi
done

# Path configuration
SVG_SOURCE="assets/img/favicons/note-icon.svg"
OUTPUT_DIR="assets/img/favicons"

# Create various PNG sizes from SVG
echo "Generating PNG favicons from SVG..."

# Favicon 16x16
rsvg-convert -w 16 -h 16 "$SVG_SOURCE" -o "${OUTPUT_DIR}/favicon-16x16.png"

# Favicon 32x32
rsvg-convert -w 32 -h 32 "$SVG_SOURCE" -o "${OUTPUT_DIR}/favicon-32x32.png"

# Android Chrome 192x192
rsvg-convert -w 192 -h 192 "$SVG_SOURCE" -o "${OUTPUT_DIR}/android-chrome-192x192.png"

# Android Chrome 512x512
rsvg-convert -w 512 -h 512 "$SVG_SOURCE" -o "${OUTPUT_DIR}/android-chrome-512x512.png"

# Apple Touch Icon 180x180
rsvg-convert -w 180 -h 180 "$SVG_SOURCE" -o "${OUTPUT_DIR}/apple-touch-icon.png"

# MS Tile 150x150
rsvg-convert -w 150 -h 150 "$SVG_SOURCE" -o "${OUTPUT_DIR}/mstile-150x150.png"

# Generate ICO file with multiple sizes
echo "Generating favicon.ico..."
convert "${OUTPUT_DIR}/favicon-16x16.png" "${OUTPUT_DIR}/favicon-32x32.png" "${OUTPUT_DIR}/favicon.ico"

echo "Favicon generation complete!"
echo "To apply favicons, run: ./tools/generate-favicons.sh"
echo "Note: Please make sure your web server correctly serves SVG files with the 'image/svg+xml' MIME type."
