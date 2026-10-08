#!/usr/bin/env bash
# Introspection SETUP: set a distinctive allowed-extensions value so an inspecting agent can read
# it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset taxonomy_import.config file_extensions 'csv xml json' -y >/dev/null 2>&1
echo "setup: taxonomy_import.config file_extensions='csv xml json'"
