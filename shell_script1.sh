#!/bin/bash

input_file="input.txt"  # Replace with your input file's name
output_file="output.txt"  # Replace with your desired output file's name

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found."
    exit 1
fi

# Generate word frequencies and sort them
cat "$input_file" | tr '[:upper:]' '[:lower:]' | tr -s '[:punct:]' ' ' | tr ' ' '\n' | sort | uniq -c | sort -nr > "$output_file"

echo "Word frequencies written to $output_file"
