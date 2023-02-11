#!/bin/bash
INPUT_DIR=../input
OUTPUT_DIR=../output

INPUT_FILE="${OUTPUT_DIR}/OS231 REGISTRATION.csv"
INPUT_FILE_CLEAN="${OUTPUT_DIR}/OS231_REGISTRATION.csv"
mv "$INPUT_FILE" "$INPUT_FILE_CLEAN"


OUTPUT_FILE_NAME='OS231_GH.txt'
OUTPUT_FILE="${OUTPUT_DIR}/${OUTPUT_FILE_NAME}"
YES=y

if test -f "$OUTPUT_FILE"; then
    read -p 'Output file exists. Delete and start anew? {y/N}: ' DELETE_FLAG
    # if [${DELETE_FLAG,,} = ${YES,,}]; then
    #     echo "Deleting..."
    # fi
    echo $DELETE_FLAG | grep -qi '[yY]' && rm $OUTPUT_FILE || echo "not deleting"
fi


col=5
awk -F',' -v col="$col" '{print $col}' $INPUT_FILE_CLEAN > $OUTPUT_FILE

echo "Done Writing. Deleting first line."
sed -i '1d' $OUTPUT_FILE
echo "Done. Byebye. ☄️"
exit 0