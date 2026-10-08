#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset node_export.settings node_export_import replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_export.settings node_export_import=replace"
