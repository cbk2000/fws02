#!/bin/bash

GH_USER="cbk2000"
# Check if current directory is a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not in a git repository" >&2
  exit 1
fi

# Check if remote URL is from a GitHub organization
remote_url=$(git config --get remote.origin.url)
if [[ $remote_url != *github.com:*/* ]]; then
  echo "Warning: remote URL is not from a GitHub organization!" >&2
fi

# Get the latest release from the current git repository using the GitHub API
repo=$(basename `git rev-parse --show-toplevel`)
url="https://api.github.com/repos/$GH_USER/$repo/releases/latest"
assets_url=$(curl -s "$url" | grep browser_download_url | grep tar.gz | cut -d '"' -f 4)
wget -O release.tar.gz "$assets_url"
