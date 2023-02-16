#!/bin/bash

source fs_chk.sh

pdir=$(cd "$(dirname "$0")"; pwd)
cd "$pdir"

# Define directories and filenames
INPUT_DIR="$pdir/input"
INPUT_FILE="i02.txt"
INPUT_PATH="$INPUT_DIR/$INPUT_FILE"
OUTPUT_DIR="$pdir/output"
OUTPUT_FILE="o2.txt"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

check_filesystem "$INPUT_DIR" "$INPUT_PATH" "$OUTPUT_DIR" "$OUTPUT_PATH"

# Initialize section header
section_header=""

# Initialize question contents
question_contents=""

# Initialize answer
answer=""

last_line=$(wc -l < $INPUT_PATH)
current_line=0

# Read input file line by line
while IFS= read -r line
do
  current_line=$(($current_line + 1))
  # If line starts with ZCZC, set section header
  if [[ $line == ZCZC* ]]; then
    section_header=$line
  fi

  # If line starts with T: or F:, set question contents and answer
  if [[ $line == T:* ]]; then
    # echo "line contains T"
    question_contents=${line#T:}
    answer="A"
  elif [[ $line == F:* ]]; then
    # echo "line contains F"
    question_contents=${line#F:}
    answer="B"
  fi

  # If line is not empty and does not start with T: or F:, append line to question contents
  if [[ ! -z "$line" && $line != T:* && $line != F:* ]]; then
    question_contents="$question_contents
$line"
  fi

  # If line is empty, write formatted output to output file
  if [[ -z "$line" || $current_line == $last_line ]] && [[ "$answer" == "A" || "$answer" == "B" ]]; then

    echo "# ############# XXXXX" >> $OUTPUT_PATH
    echo "$section_header" |  tr -d '\n' >> $OUTPUT_PATH
    echo "$question_contents" >> $OUTPUT_PATH
    echo "---" >> $OUTPUT_PATH
    echo "A. true" >> $OUTPUT_PATH
    echo "B. false" >> $OUTPUT_PATH
    echo "ANSWER: $answer" >> $OUTPUT_PATH
    echo "" >> $OUTPUT_PATH

    # Reset question contents and answer
    question_contents=""
    answer=""
  fi
done < "$INPUT_PATH"
echo "Done. Byebye. ☄️"
exit 0
