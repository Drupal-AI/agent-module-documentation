#!/usr/bin/env bash
# Introspection SETUP: set a distinctive max upload size so an inspecting agent can read it back.
set -uo pipefail
cd /var/www/html
drush cset taxonomy_import.config file_max_size 12345678 -y >/dev/null 2>&1
echo "setup: taxonomy_import.config file_max_size=12345678"
