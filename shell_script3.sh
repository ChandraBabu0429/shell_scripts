#!/bin/bash

input_file="input.txt"  # Replace with your input file's name
output_file="output.txt"  # Replace with your desired output file's name

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found."
    exit 1
fi

# Reverse the order of characters in each line and write to the output file
awk '{ for(i=length($0);i!=0;i--) printf "%s",substr($0,i,1); printf "\n" }' "$input_file" > "$output_file"

echo "Lines reversed and written to $output_file"
