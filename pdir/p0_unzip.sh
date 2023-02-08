#!/bin/bash
INPUT_DIR=../input
OUTPUT_DIR=../output


if [ ! -d "$INPUT_DIR" ]; then
  echo "Error: $INPUT_DIR directory does not exist."
  exit 1
fi

INPUT_FILE="${INPUT_DIR}/OS231 REGISTRATION.csv.zip"

echo $INPUT_FILE

if [ ! -d "$OUTPUT_DIR" ]; then
  echo "Error: $OUTPUT_DIR directory does not exist. Creating now."
  mkdir $OUTPUT_DIR
  
fi

unzip "$INPUT_FILE" -d $OUTPUT_DIR