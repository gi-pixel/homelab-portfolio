#!/bin/bash

read -p "Enter commit message: " message

echo "Adding all changes..."
git add .

git commit -m "$message"

echo "Pushing changes..."
git push origin main

echo "Push complete..."
