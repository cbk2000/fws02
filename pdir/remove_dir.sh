function remove_empty_directory() {
  if [ -d "$1" ] && [ -z "$(ls -A "$1")" ]; then
    rm -r "$1"
    echo "Removed empty directory: $1"
  fi
}