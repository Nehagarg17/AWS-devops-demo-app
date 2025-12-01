#!/bin/bash
set -e
# where releases live
RELEASE_DIR=/opt/app/releases
CURRENT_DIR=/opt/app/current

mkdir -p ${RELEASE_DIR}
cd ${RELEASE_DIR}

# Remove stale tmp
rm -rf tmp unpack || true
mkdir -p tmp
unzip -o app.zip -d tmp

# Move unpacked to timestamped folder
TS=$(date +%s)
mkdir -p ${RELEASE_DIR}/${TS}
mv tmp/* ${RELEASE_DIR}/${TS}/
rm -rf tmp

# Update current symlink atomically
ln -sfn ${RELEASE_DIR}/${TS} ${CURRENT_DIR}

# Install dependencies in the current release
cd ${CURRENT_DIR}
# If you want production-only
npm ci --production
