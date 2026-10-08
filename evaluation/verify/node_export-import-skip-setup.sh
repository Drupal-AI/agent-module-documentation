#!/usr/bin/env bash
# Introspection SETUP: set the import-existing strategy to 'skip' so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_export.settings node_export_import skip -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node_export.settings node_export_import=skip"
