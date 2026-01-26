#!/bin/bash
# Image Optimization Script for carluve.dev
# Uses macOS sips to resize large images

set -e

IMG_DIR="public/assets/img/2025"
MAX_WIDTH=1600
MAX_HEIGHT=1200
QUALITY=85

echo "🖼️  Optimizing images in $IMG_DIR..."
echo "   Max dimensions: ${MAX_WIDTH}x${MAX_HEIGHT}"
echo ""

# Function to optimize a single image
optimize_image() {
    local file="$1"
    local filename=$(basename "$file")
    local size_before=$(stat -f%z "$file")
    
    # Get current dimensions
    local width=$(sips -g pixelWidth "$file" | tail -1 | awk '{print $2}')
    local height=$(sips -g pixelHeight "$file" | tail -1 | awk '{print $2}')
    
    # Skip if already small enough
    if [[ $width -le $MAX_WIDTH && $height -le $MAX_HEIGHT ]]; then
        return 0
    fi
    
    echo "📐 Resizing: $filename (${width}x${height})"
    
    # Calculate new dimensions maintaining aspect ratio
    if [[ $width -gt $height ]]; then
        # Landscape
        sips --resampleWidth $MAX_WIDTH "$file" --out "$file" > /dev/null 2>&1
    else
        # Portrait
        sips --resampleHeight $MAX_HEIGHT "$file" --out "$file" > /dev/null 2>&1
    fi
    
    local size_after=$(stat -f%z "$file")
    local saved=$((size_before - size_after))
    local saved_mb=$(echo "scale=2; $saved / 1048576" | bc)
    
    echo "   ✅ Saved: ${saved_mb}MB"
}

# Find and optimize large PNG files (>1MB)
echo "🔍 Finding large images..."
find "$IMG_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -size +1M | while read file; do
    optimize_image "$file"
done

echo ""
echo "✨ Done! Run 'git status' to see changes."
