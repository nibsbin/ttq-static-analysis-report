#!/bin/bash

# Ensure we are in the project root
cd "$(dirname "$0")/.."

# Ensure pdfs directory exists
mkdir -p pdfs

compile_template() {
  local template=$1
  local input="template/${template}.typ"
  local output="pdfs/${template}-{p}.png"

  if [ ! -f "$input" ]; then
    echo "Skipping ${template}: template file not found ($input)"
    return 0
  fi

  echo "Compiling ${template}..."
  # Prefer using the bundled fonts directory if present
  local font_path="fonts"
  if [ ! -d "$font_path" ]; then
    font_path="."
  fi

  if typst compile --font-path "$font_path" --root . "$input" "$output"; then
    echo "  ✓ Generated: $(pwd)/pdfs/${template}-*.png"
  else
    echo "  ✗ Failed to compile $template"
    return 1
  fi
}

echo "Building templates..."
echo

# Templates to build (order matters for multi-output projects)
templates=("report" "resume")

for t in "${templates[@]}"; do
  if ! compile_template "$t"; then
    echo "Build failed while compiling: $t"
    exit 1
  fi
  echo
done

echo "All compilations completed."
