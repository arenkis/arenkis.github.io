#!/bin/bash

# Define paths
OBSIDIAN_PUBLIC="/Users/sotapanna/Sync/Obsidian/Public"
QUARTZ_CONTENT="/Users/sotapanna/Sync/Software/quartz/content"
QUARTZ_DIR="/Users/sotapanna/Sync/Software/quartz"

# Ensure the destination exists
mkdir -p "$QUARTZ_CONTENT"

# Remove old files in Quartz content folder
rm -rf "$QUARTZ_CONTENT"/*

# Copy new files from Obsidian Public folder to Quartz content
cp -R "$OBSIDIAN_PUBLIC"/. "$QUARTZ_CONTENT"

# Change to Quartz directory
cd "$QUARTZ_DIR" || exit

# Check if there are changes
if [ -n "$(git status --porcelain)" ]; then
    echo "Changes detected. Committing and pushing..."
    git add .
    git commit -m "Auto-sync from Obsidian Public to Quartz"
    git push origin main
else
    echo "No changes detected. Skipping push."
fi


echo "✅ Public folder copied & changes published!"