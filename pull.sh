#!/bin/bash

branch=$(git branch --show-current)

if [ -z "$branch" ]; then
    echo "Not inside a git repository."
    exit 1
fi

echo "Fetching latest changes..."
git fetch origin

echo ""
echo "Incoming commits:"
git log HEAD..origin/$branch --oneline

echo ""
read -p "Do you want to pull these changes? (y/n): " answer

if [ "$answer" = "y" ]; then
    git pull origin $branch
    echo "Repository updated."
else
    echo "Pull skipped."
fi
