#!/bin/bash

# Define input and output files
input_file="../input/i02.txt"
output_file="../output/o2.txt"

# Initialize section header
section_header=""

# Initialize question contents
question_contents=""

# Initialize answer
answer=""

# Read input file line by line
while IFS= read -r line
do
  # If line starts with ZCZC, set section header
  if [[ $line == ZCZC* ]]; then
    section_header=$line
  fi

  # If line starts with T: or F:, set question contents and answer
  if [[ $line == T:* ]]; then
    question_contents=${line#T:}
    answer="A"
  elif [[ $line == F:* ]]; then
    question_contents=${line#F:}
    answer="B"
  fi

  # If line is not empty and does not start with T: or F:, append line to question contents
  if [[ ! -z "$line" && $line != T:* && $line != F:* ]]; then
    question_contents="$question_contents
$line"
  fi

  echo $line

  # If line is empty, write formatted output to output file
  if [[ -z "$line" ]] && [[ "$answer" == "A" || "$answer" == "B" ]]; then

    echo "# ############# XXXXX" >> $output_file
    echo "$section_header" >> $output_file
    echo "$question_contents" >> $output_file
    echo "---" >> $output_file
    echo "A. true" >> $output_file
    echo "B. false" >> $output_file
    echo "ANSWER: $answer" >> $output_file
    echo "" >> $output_file

    # Reset question contents and answer
    question_contents=""
    answer=""
  fi
done < "$input_file"
