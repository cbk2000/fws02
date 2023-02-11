#!/bin/bash

# Input file path
INPUT_FILE="../input/i02.txt"

# Output file path
OUTPUT_FILE="../output/o2.txt"

# Counter to keep track of number of sections processed
section_counter=0

# Function to process a section
process_section () {
  local section_header=$1
  local statement=$2
  local truthiness=$3

  # Remove ZCZC from the section header
  section_header=${section_header#ZCZC }

  # Print the section header
  echo -e "# ############# $section_counter\n$section_header\n$statement\n---\nA. true\nB. false\nANSWER: " >> $OUTPUT_FILE

  # Check truthiness of the statement and append the answer
  if [ "$truthiness" == "T:" ]; then
    echo "A" >> $OUTPUT_FILE
  else
    echo "B" >> $OUTPUT_FILE
  fi
}

# Remove contents of the output file
> $OUTPUT_FILE

# Read the input file line by line
while IFS= read -r line; do
  # Check if the line starts with ZCZC
  if [[ "$line" == ZCZC* ]]; then
    # If this is not the first section, process the previous section
    if [ $section_counter -gt 0 ]; then
      process_section "$section_header" "$statement" "$truthiness"
    fi

    # Reset variables for the new section
    section_header=$line
    statement=""
    truthiness=""

    # Increment the section counter
    ((section_counter++))
  else
    # Check if the line starts with T: or F:
    if [[ "$line" == T:* || "$line" == F:* ]]; then
      truthiness=$line
    else
      # Add the line to the statement
      statement="$statement\n$line"
    fi
  fi
done < $INPUT_FILE

# Process the last section
process_section "$section_header" "$statement" "$truthiness"
