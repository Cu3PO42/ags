#!/usr/bin/env bash

TS_FOR_GIR="$(dirname "$0")/node_modules/.bin/ts-for-gir"

BUILD_DIR="$1"
INPUT_FILES=("${@:2:$(($#-1))}")
OUTPUT_DIR="${@: -1}"

INPUT_FILES_NO_EXT=()
for file in "${INPUT_FILES[@]}"; do
  INPUT_FILES_NO_EXT+=("$(basename "$file" .gir)")
done

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
mkdir -p "$TMP_DIR/gir-1.0"
cp "${INPUT_FILES[@]}" "$TMP_DIR/gir-1.0"

export XDG_DATA_DIRS="$TMP_DIR:$XDG_DATA_DIRS"

$TS_FOR_GIR generate --package --outdir "$OUTPUT_DIR" "${INPUT_FILES_NO_EXT[@]}"