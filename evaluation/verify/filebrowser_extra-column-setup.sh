#!/usr/bin/env bash
# Introspection SETUP: ensure the filebrowser_extra example submodule is enabled so its
# "modified" metadata column is contributed to Filebrowser listings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en filebrowser_extra -y >/dev/null 2>&1
echo "setup: filebrowser_extra enabled (adds 'modified' listing column)"
