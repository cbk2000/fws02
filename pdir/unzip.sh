#!/bin/bash

function extract_archive {
  # Check for input file argument
  if [ -z "$1" ]; then
    echo "Error: No input file specified."
    exit 1
  fi

  # Check for output directory argument
  if [ -z "$2" ]; then
    echo "Error: No output directory specified."
    exit 1
  fi

  # Check if unzip is installed
  if which unzip >/dev/null 2>&1; then
    unzip "$1" -d "$2"
    echo "Sucessfully extracted archive."
    return 0
  # Check if bsdtar is installed
  elif which bsdtar >/dev/null 2>&1; then
    bsdtar -xf "$1" -C "$2"
    echo "Sucessfully extracted archive."
    return 0
  # Check if 7z is installed
  elif which 7z >/dev/null 2>&1; then
    7z x "$1" -o"$2"
    echo "Sucessfully extracted archive."
    return 0
  fi

  # If no suitable program found, prompt the user to install unzip
  echo "Error: No suitable program found to extract the archive."
  echo "Please install 'unzip', 'bsdtar', or '7z' and try again."
  return 1
}