#!/bin/bash

pdir=$(cd "$(dirname "$0")"; pwd)
cd "$pdir/.."

# Define directories and filenames
input_dir="./input"
input_file="i02.txt"
input_path="$input_dir/$input_file"
output_dir="./output"
output_file="o2.txt"
output_path="$output_dir/$output_file"

#FS Checks
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

if [ -f "$output_path" ]; then
echo "Output file already exists."
read -p "Do you want to (o)verwrite, (a)ppend or (q)uit? " choice

case $choice in
o) rm "$output_path";;
a) :;;
q) exit 1;;
*) echo "Invalid option, quitting."; exit;;
esac
fi


# Initialize section header
section_header=""

# Initialize question contents
question_contents=""

# Initialize answer
answer=""

last_line=$(wc -l < $input_path)
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

  # echo "current question contents are ${question_contents}"


  # If line is empty, write formatted output to output file
  if [[ -z "$line" || $current_line == $last_line ]] && [[ "$answer" == "A" || "$answer" == "B" ]]; then

    echo "# ############# XXXXX" >> $output_path
    echo "$section_header" >> $output_path
    echo "$question_contents" >> $output_path
    echo "---" >> $output_path
    echo "A. true" >> $output_path
    echo "B. false" >> $output_path
    echo "ANSWER: $answer" >> $output_path
    echo "" >> $output_path

    # Reset question contents and answer
    question_contents=""
    answer=""
  fi
done < "$input_path"
echo "Done."
exit 0
