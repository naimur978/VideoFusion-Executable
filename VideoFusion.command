#!/bin/bash

# Video Merger - Double-click to merge all videos in current folder
echo "🎬 Video Merger - Starting..."

# Check if ffmpeg exists
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ ffmpeg not found. Please install it first:"
    echo "   brew install ffmpeg"
    echo "Press any key to exit..."
    read -n 1
    exit 1
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
echo "📁 Working directory: $SCRIPT_DIR"

echo "📂 Scanning for video files..."

# Find all video files (excluding output.mp4)
VIDEO_FILES=()
while IFS= read -r -d '' file; do
    if [[ "$(basename "$file")" != "output.mp4" ]]; then
        VIDEO_FILES+=("$file")
    fi
done < <(find . -maxdepth 1 -name "*.mp4" -type f -print0)

# Also check for other video formats, including TS
for ext in mov avi mkv wmv flv webm m4v ts MOV AVI MKV WMV FLV WEBM M4V TS; do
    while IFS= read -r -d '' file; do
        basename_file="$(basename "$file")"
        if [[ "$basename_file" != "output.mp4" ]]; then
            VIDEO_FILES+=("$file")
        fi
    done < <(find . -maxdepth 1 -name "*.$ext" -type f -print0 2>/dev/null)
done

if [ ${#VIDEO_FILES[@]} -eq 0 ]; then
    echo "❌ No video files found in current directory"
    echo "Press any key to exit..."
    read -n 1
    exit 1
fi

echo "📹 Found ${#VIDEO_FILES[@]} video files:"
for i in "${!VIDEO_FILES[@]}"; do
    echo "   $((i+1)). $(basename "${VIDEO_FILES[i]}")"
done

# Check if output.mp4 already exists
if [ -f "output.mp4" ]; then
    echo ""
    echo "⚠️  output.mp4 already exists. Overwrite? (y/N)"
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Cancelled by user"
        echo "Press any key to exit..."
        read -n 1
        exit 1
    fi
    rm -f "output.mp4"
fi

echo ""
echo "🔄 Merging videos..."

# Create file list for ffmpeg
TEMP_LIST=$(mktemp)
for file in "${VIDEO_FILES[@]}"; do
    abs_path="$(realpath "$file")"
    echo "file '$abs_path'" >> "$TEMP_LIST"
done

# Try fast concat first (works for same format files)
echo "   Trying fast mode (no re-encoding)..."
if ffmpeg -f concat -safe 0 -i "$TEMP_LIST" -c copy "output.mp4" -y -v error -stats; then
    echo "✅ Fast merge successful!"
else
    echo "⚠️  Fast merge failed, trying re-encoding..."
    # Fallback to re-encoding
    if ffmpeg -f concat -safe 0 -i "$TEMP_LIST" -c:v libx264 -c:a aac "output.mp4" -y -v error -stats; then
        echo "✅ Re-encoding merge successful!"
    else
        echo "❌ Failed to create output.mp4"
        rm -f "$TEMP_LIST"
        echo "Press any key to exit..."
        read -n 1
        exit 1
    fi
fi

# Cleanup
rm -f "$TEMP_LIST"

# Show result
if [ -f "output.mp4" ] && [ -s "output.mp4" ]; then
    FILE_SIZE=$(ls -lh "output.mp4" | awk '{print $5}')
    DURATION=$(ffprobe -v quiet -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "output.mp4" 2>/dev/null)
    if [[ -n "$DURATION" ]]; then
        MINUTES=$((${DURATION%.*} / 60))
        SECONDS=$((${DURATION%.*} % 60))
        echo ""
        echo "🎉 Success! Created output.mp4"
        echo "📦 Size: $FILE_SIZE"
        echo "⏱️  Duration: ${MINUTES}m ${SECONDS}s"
    else
        echo ""
        echo "🎉 Success! Created output.mp4"
        echo "📦 Size: $FILE_SIZE"
    fi
else
    echo "❌ Something went wrong - output.mp4 not created"
fi

echo ""
echo "Press any key to close..."
read -n 1
