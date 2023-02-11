#!/bin/bash

cd ..
#!/bin/bash

input_file="input/i02.txt"
output_file="output/o2.txt"

if [ ! -d "input" ]; then
  echo "Error: input directory does not exist. Exiting with code 1."
  exit 1
fi

if [ ! -d "output" ]; then
  echo "Creating output directory."
  mkdir output
fi

if [ -s "$output_file" ]; then
  echo "File $output_file already exists and is not empty. Choose an option: "
  echo "1. Overwrite"
  echo "2. Append"
  echo "3. Abort"
  read -p "Enter your choice (1/2/3): " choice

  if [ "$choice" == "1" ]; then
    echo "Overwriting $output_file"
  elif [ "$choice" == "2" ]; then
    echo "Appending to $output_file"
  elif [ "$choice" == "3" ]; then
    echo "Aborting operation."
    exit 0
  else
    echo "Invalid choice. Aborting operation."
    exit 1
  fi
fi

while read line; do
  if [[ "$line" == ZCZC* ]]; then
    echo -e "$line\n" >> "$output_file"
  elif [[ "$line" == T:* ]]; then
    echo -e "$line\nIMG:" >> "$output_file"
    echo -e "---\nA. true\nB. false\nANSWER: A\n" >> "$output_file"
  elif [[ "$line" == F:* ]]; then
    echo -e "$line\nIMG:" >> "$output_file"
    echo -e "---\nA. true\nB. false\nANSWER: B\n" >> "$output_file"
  else
    echo "$line" >> "$output_file"
  fi
done < "$input_file"
