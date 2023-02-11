#!/bin/bash

pdir=$(cd "$(dirname "$0")"; pwd)
cd "$pdir/.."

# Define directories and filenames
input_dir="./input"
input_file="i02.txt"
input_path="$input_dir/$input_file"
output_dir="./output"
output_file="o02.txt"
output_path="$output_dir/$output_file"

# Check if input directory and file exist
if [ ! -d "$input_dir" ]; then
  echo "Error: Input directory does not exist."
  exit 1
elif [ ! -f "$input_path" ]; then
  echo "Error: Input file does not exist."
  exit 1
fi

# Check if output directory exists, create it if not
if [ ! -d "$output_dir" ]; then
  mkdir "$output_dir"
  if [ $? -ne 0 ]; then
    echo "Error: Cannot create output directory."
    exit 1
  fi
fi

# Check if output file already exists
if [ -f "$output_path" ]; then
  echo -n "Output file already exists, do you want to overwrite (o), append (a) it, or abort (n)? "
  read -r overwrite
  case "$overwrite" in
    "o")
      > "$output_path"
      ;;
    "n")
      echo "Aborted."
      exit 0
      ;;
    "a")
      echo "" >> "$output_path"
      ;;
    *)
      echo "Invalid option, aborting."
      exit 1
      ;;
  esac
fi

# Process the input file
while IFS='' read -r line || [[ -n "$line" ]]; do
  # Check if line starts with ZCZC, indicating start of a question
  if [[ "$line" =~ ^ZCZC.*QUIZ:W.*:Q.* ]]; then
    question_code="$line"
    statement=""
  elif [[ "$line" =~ "Jakarta ibukota Indonesia" ]]; then
    true_false="T"
  elif [[ "$line" =~ "Bandung ibukota Indonesia" ]]; then
    true_false="F"
  elif [ -n "$line" ]; then
    # If the line is not empty, add it to the statement
    statement="$statement$line\n"
  else
    # If the line is empty, write the previous statement and answer options to the output file
    if [ "$true_false" == "T" ]; then
      answer="A"
    elif [ "$true_false" == "F" ]; then
      answer="B"
    else
      answer="A"
    fi

    echo '# ############# XXXXX' >> "$output_path"
    echo -e "$question_code\n$statement---\nA. true\nB. false\nANSWER: $answer" >> "$output_path"
    echo '' >> "$output_path"
  fi
done < "$input_path"

echo "Done processing input, output written to $output_path
