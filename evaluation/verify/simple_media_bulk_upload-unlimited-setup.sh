#!/usr/bin/env bash
# Introspection SETUP: set max_files to 0 (unlimited) so an agent can detect the "no limit"
# state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset simple_media_bulk_upload.settings max_files 0 -y >/dev/null 2>&1
echo "setup: simple_media_bulk_upload.settings max_files=0 (unlimited)"
