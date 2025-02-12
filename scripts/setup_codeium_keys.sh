#!/usr/bin/env bash

set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <container>" >&2
  exit 1
fi

CONTAINER_NAME="$1"
CODEIUM_CACHE_DIR="${HOME}/.cache/nvim/codeium"
CODEIUM_CACHE_PATH="${CODEIUM_CACHE_DIR}/config.json"

# Check the vim std path cache directory for a codeium json file
if [ -f "${CODEIUM_CACHE_PATH}" ]; then
  echo "Found ${CODEIUM_CACHE_PATH} config file."
else
  echo "Error: codeium config file not found." >&2
  exit 1
fi

# Make sure the config path exists in the docker container
if ! docker exec "${CONTAINER_NAME}" mkdir -p "${CODEIUM_CACHE_DIR}"; then
  echo "Error: Failed to create directory in container." >&2
  exit 1
fi

# Copy the codeium config with docker and insert into target container
if docker cp "${CODEIUM_CACHE_PATH}" "${CONTAINER_NAME}:/root/.cache/nvim/codeium"; then
  echo "Successfully copied config to container."
else
  echo "Error: Failed to copy config to container." >&2
  exit 1
fi
