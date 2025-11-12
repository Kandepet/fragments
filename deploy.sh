#!/bin/bash

# Encrypted URL Shortener - GitHub Pages Deployment Script
# This script helps you deploy the encrypted URL shortener to GitHub Pages

set -e

echo "🔐 Encrypted URL Shortener - Deployment Script"
echo "=============================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed. Please install git first."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Get GitHub username
echo ""
read -p "Enter your GitHub username: " github_username

if [ -z "$github_username" ]; then
    echo "❌ Error: GitHub username cannot be empty"
    exit 1
fi

# Get repository name
echo ""
read -p "Enter repository name (default: encrypted-links): " repo_name
repo_name=${repo_name:-encrypted-links}

# Ask about custom domain
echo ""
read -p "Do you want to use a custom domain? (y/n, default: n): " use_custom_domain
use_custom_domain=${use_custom_domain:-n}

if [ "$use_custom_domain" = "y" ]; then
    read -p "Enter your custom domain (e.g., devel.sh): " custom_domain
    if [ -n "$custom_domain" ]; then
        echo "$custom_domain" > CNAME
        echo "✅ CNAME file created with domain: $custom_domain"
        echo ""
        echo "⚠️  Don't forget to configure your DNS:"
        echo "   Add a CNAME record pointing to: ${github_username}.github.io"
    fi
else
    # Remove CNAME file if it exists and user doesn't want custom domain
    if [ -f CNAME ]; then
        rm CNAME
        echo "✅ CNAME file removed"
    fi
fi

# Check if remote exists
if git remote get-url origin &> /dev/null; then
    echo ""
    echo "⚠️  Remote 'origin' already exists. Removing it..."
    git remote remove origin
fi

# Add remote
echo ""
echo "🔗 Adding GitHub remote..."
git remote add origin "https://github.com/${github_username}/${repo_name}.git"
echo "✅ Remote added: https://github.com/${github_username}/${repo_name}"

# Stage files
echo ""
echo "📝 Staging files..."
git add .
echo "✅ Files staged"

# Commit
echo ""
echo "💾 Creating commit..."
git commit -m "Initial commit: Encrypted URL Shortener" || echo "⚠️  No changes to commit"
echo "✅ Commit created"

# Get default branch name
default_branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")

# Rename branch to main if needed
if [ "$default_branch" != "main" ]; then
    echo ""
    echo "🔄 Renaming branch to 'main'..."
    git branch -M main
    echo "✅ Branch renamed to 'main'"
fi

echo ""
echo "=============================================="
echo "📋 NEXT STEPS:"
echo "=============================================="
echo ""
echo "1. Create the repository on GitHub:"
echo "   Go to: https://github.com/new"
echo "   Repository name: $repo_name"
echo "   Make it Public"
echo "   Don't initialize with README"
echo ""
echo "2. Push the code:"
echo "   git push -u origin main"
echo ""
echo "3. Enable GitHub Pages:"
echo "   Go to: https://github.com/${github_username}/${repo_name}/settings/pages"
echo "   Source: Deploy from branch 'main'"
echo "   Folder: / (root)"
echo "   Click 'Save'"
echo "   ✅ Check 'Enforce HTTPS'"
echo ""

if [ "$use_custom_domain" = "y" ] && [ -n "$custom_domain" ]; then
    echo "4. Configure custom domain in GitHub:"
    echo "   In the same Pages settings, enter: $custom_domain"
    echo "   Click 'Save'"
    echo ""
    echo "5. Wait for DNS propagation (can take up to 24 hours)"
    echo ""
    echo "Your site will be available at:"
    echo "   https://$custom_domain"
else
    echo "Your site will be available at:"
    echo "   https://${github_username}.github.io/${repo_name}/"
fi

echo ""
echo "=============================================="
echo "🎉 Setup complete! Follow the steps above."
echo "=============================================="
