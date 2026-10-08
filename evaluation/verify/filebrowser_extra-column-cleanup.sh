#!/usr/bin/env bash
# Introspection CLEANUP: baseline has filebrowser_extra enabled; ensure it stays enabled.
set -uo pipefail
cd /var/www/html
drush en filebrowser_extra -y >/dev/null 2>&1
echo "cleanup: filebrowser_extra enabled (baseline)"
