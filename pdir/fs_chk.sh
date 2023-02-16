# Define function to check filesystem paths
function check_filesystem {
  local input_dir="$1"
  local input_path="$2"
  local output_dir="$3"
  local output_path="$4"

  if [ ! -d "$input_dir" ]; then
    echo "Error: input directory does not exist."
    exit 1
  fi

  if [ ! -f "$input_path" ]; then
    echo "Error: input file does not exist."
    exit 1
  fi

  if [ ! -d "$output_dir" ]; then
    echo "Output directory does not exist, creating it now..."
    mkdir "$output_dir"
  fi

  if [ ! -n "$output_path" ]; then
    echo "Warning: No output path specified."
  fi

  if [[ -n "$output_path" && -f "$output_path" ]]; then
    echo "Output file already exists."
    read -p "Do you want to (o)verwrite, (a)ppend or (q)uit? " choice

    case $choice in
      o) rm "$output_path";;
      a) :;;
      q) exit 1;;
      *) echo "Invalid option, quitting."; exit;;
    esac
  fi
}