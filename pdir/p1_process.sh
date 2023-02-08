#!/bin/bash
INPUT_DIR=../input
OUTPUT_DIR=../output

INPUT_FILE="${OUTPUT_DIR}/OS231 REGISTRATION.csv"
OUTPUT_FILE_NAME='OS231_GH.csv'
OUTPUT_FILE="${OUTPUT_DIR}/${OUTPUT_FILE_NAME}"
YES=y

if test -f "$OUTPUT_FILE"; then
    read -p 'Output file exists. Delete and start anew? {y/N}: ' DELETE_FLAG
    # if [${DELETE_FLAG,,} = ${YES,,}]; then
    #     echo "Deleting..."
    # fi
    echo $DELETE_FLAG | grep -qi '[yY]' && rm $OUTPUT_FILE || echo "not deleting"
fi

while IFS= read -r line; 
    do 
        echo $line | grep -o -E '[0-9]{10}' >> ${OUTPUT_FILE}
done < "${INPUT_FILE}"
echo "Done Writing"