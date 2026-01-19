#!/bin/bash

# Ensure we are in the project root
cd "$(dirname "$0")/.."

# Ensure pdfs directory exists
mkdir -p pdfs

compile_template() {
  local template=$1
  local input="template/${template}.typ"
  local output="pdfs/${template}.pdf"

  echo "Compiling ${template}..."
  if typst compile --font-path . --root . "$input" "$output"; then
    echo "  ✓ Generated: $(pwd)/$output"
  else
    echo "  ✗ Failed to compile $template"
    return 1
  fi
}

echo "Building templates..."
echo

compile_template "resume"

echo
echo "All compilations completed."
