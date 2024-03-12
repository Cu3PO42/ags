#!/usr/bin/env bash

cd "$(dirname "$0")"

TS_FOR_GIR="./node_modules/.bin/ts-for-gir"

BUILD_DIR="$1"
INPUT_FILES=("${@:2:$(($#-1))}")
OUTPUT_DIR="${@: -1}"

INPUT_FILES_NO_EXT=()
INPUT_DIRS=()
for file in "${INPUT_FILES[@]}"; do
  INPUT_FILES_NO_EXT+=("$(basename "$file" .gir)")
  INPUT_DIRS+=("$BUILD_DIR/$(dirname "$file")")
done

$TS_FOR_GIR generate --package --outdir "$OUTPUT_DIR" "${INPUT_FILES_NO_EXT[@]}" --girDirectories "${INPUT_DIRS[@]}"