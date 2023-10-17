#!/bin/bash

input_file="input.txt"  # Replace with your input file's name
output_file="output.txt"  # Replace with your desired output file's name
old_word="bhsbdab"  # Replace with the word or phrase you want to replace
new_word="CHANDU"  # Replace with the word or phrase you want to replace with

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found."
    exit 1
fi

# Replace all occurrences of old_word with new_word and write to the output file
sed "s/$old_word/$new_word/g" "$input_file" > "$output_file"

echo "All occurrences of '$old_word' replaced with '$new_word' in $output_file"
