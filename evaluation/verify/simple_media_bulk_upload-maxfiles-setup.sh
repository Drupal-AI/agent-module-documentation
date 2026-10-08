#!/usr/bin/env bash
# Introspection SETUP: set simple_media_bulk_upload max_files to a known value (12) so an
# agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset simple_media_bulk_upload.settings max_files 12 -y >/dev/null 2>&1
echo "setup: simple_media_bulk_upload.settings max_files=12"
