#!/usr/bin/env bash
# Execution RESET: force max_files to 30 so verify (expecting 0 = unlimited) FAILS until the
# agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset simple_media_bulk_upload.settings max_files 30 -y >/dev/null 2>&1
echo "reset: simple_media_bulk_upload.settings max_files=30"
