#!/usr/bin/env bash
# Execution RESET: force strategy back to 'replace' so verify fails until agent sets 'skip'. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_export.settings node_export_import replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node_export.settings node_export_import=replace"
