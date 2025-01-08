#!/bin/bash

# Exit on error
set -e

# Configuration
REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)
echo "Repository name: $REPO_NAME"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored status messages
print_status() {
    echo -e "${BLUE}➡ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if repository has uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    print_error "You have uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Build Flutter web app with CanvasKit renderer
print_status "Building Flutter web app..."
flutter build web --release \
    --web-renderer canvaskit \
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=/$REPO_NAME/canvaskit/ \
    --base-href "/$REPO_NAME/" || { print_error "Flutter build failed"; exit 1; }
print_success "Flutter build completed"

# Create and switch to gh-pages branch
print_status "Switching to gh-pages branch..."
git checkout gh-pages 2>/dev/null || git checkout -b gh-pages
print_success "Now on gh-pages branch"

# Remove old files except .git and build/web
print_status "Cleaning old files..."
find . -maxdepth 1 ! -name '.git' ! -name 'build' ! -name '.' -exec rm -rf {} +
print_success "Old files cleaned"

# Create canvaskit directory and copy files
print_status "Setting up CanvasKit..."
mkdir -p $REPO_NAME/canvaskit/
cp -r build/web/canvaskit/* $REPO_NAME/canvaskit/
print_success "CanvasKit setup completed"

# Move built files to root
print_status "Moving built files to root..."
mv -f build/web/* .
#cp build/web/404.html .
rm -rf build
print_success "Files moved successfully"

# # Move built files to root
# print_status "Moving built files to root..."
# mv -f build/web/* .
# rm -rf build
# print_success "Files moved successfully"

# Stage and commit changes
print_status "Committing changes..."
git add -A
git commit -m "Deploy to GitHub Pages: $(date +'%Y-%m-%d %H:%M:%S')" || {
    print_error "Nothing to commit"
    exit 1
}

# Push to GitHub
print_status "Pushing to GitHub..."
git push origin gh-pages || {
    print_error "Failed to push to GitHub"
    exit 1
}
print_success "Successfully deployed to GitHub Pages"

# Switch back to previous branch
print_status "Switching back to previous branch..."
git checkout -
print_success "Deployment complete! 🚀"

echo -e "\nYour app should be available at: ${GREEN}https://$(git config --get remote.origin.url | \
    sed -n 's/.*github.com[:\/]\([^/]*\)/\1/p' | \
    sed 's/\.git$//').github.io/$REPO_NAME${NC}"