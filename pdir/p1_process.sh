#!/bin/bash

source fs_chk.sh
source remove_dir.sh

pdir=$(cd "$(dirname "$0")"; pwd)
cd "$pdir"

INPUT_DIR="$pdir/temp"
INPUT_FILE="DUMMY-REGISTRATION.csv"
INPUT_PATH="$INPUT_DIR/$INPUT_FILE"
OUTPUT_DIR="$pdir/output"
OUTPUT_FILE="o2.txt"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"
GH_COL=5


check_filesystem "$INPUT_DIR" "$INPUT_PATH" "$OUTPUT_DIR" "$OUTPUT_PATH"

awk -F',' -v col="$GH_COL" '{print $GH_COL}' $INPUT_PATH > $OUTPUT_PATH

echo "Done Writing. Deleting first line."
sed -i '1d' $OUTPUT_PATH
echo "Cleaning temporary .csv file."
rm $INPUT_PATH
remove_empty_directory $OUTPUT_DIR
echo "Done. Byebye. ☄️"
exit 0