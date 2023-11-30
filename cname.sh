#!/bin/bash

# Default output file
output_file="cnames.txt"

# Function to display usage information
usage() {
  echo "Usage: $0 [-l <list_file> | -d <single_domain>] [-o <output_file>]"
  exit 1
}

# Parse command-line options
while getopts ":l:d:o:" opt; do
  case $opt in
    l)
      list_file="$OPTARG"
      ;;
    d)
      single_domain="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      usage
      ;;
  esac
done

# Check if only one mode is specified
if [ -n "$list_file" ] && [ -n "$single_domain" ]; then
  echo "Specify either a list file (-l) or a single domain (-d), not both."
  usage
fi

# Check if the list file or single domain is provided
if [ -z "$list_file" ] && [ -z "$single_domain" ]; then
  echo "Specify either a list file (-l) or a single domain (-d)."
  usage
fi

# Check if the list file exists
if [ -n "$list_file" ] && [ ! -f "$list_file" ]; then
  echo "List file not found: $list_file"
  exit 1
fi

# Query CNAME record for a single domain
if [ -n "$single_domain" ]; then
  cname=$(dig +short CNAME "$single_domain")

  if [ -z "$cname" ]; then
    echo "No CNAME record found for $single_domain."
  else
    echo "CNAME record for $single_domain: $cname"
  fi

  exit 0
fi

# Read each line (domain) from the list file
while IFS= read -r domain; do
  # Query the CNAME record using dig command
  cname=$(dig +short CNAME "$domain")

  # Check if the CNAME record exists
  if [ -z "$cname" ]; then
    echo "No CNAME record found for $domain."
  else
    echo "CNAME record for $domain: $cname"
    echo "$domain: $cname" >> "$output_file"
  fi
done < "$list_file"
