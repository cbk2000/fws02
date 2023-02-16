#!/bin/bash

source fs_chk.sh
source unzip.sh

pdir=$(cd "$(dirname "$0")"; pwd)
cd "$pdir"

# Define directories and filenames
INPUT_DIR="$pdir/input"
INPUT_FILE="DUMMY-REGISTRATION.csv.zip"
INPUT_PATH="$INPUT_DIR/$INPUT_FILE"
OUTPUT_DIR="$pdir/temp"

check_filesystem "$INPUT_DIR" "$INPUT_PATH" "$OUTPUT_DIR"

extract_archive "$INPUT_PATH" "$OUTPUT_DIR"

exit 0