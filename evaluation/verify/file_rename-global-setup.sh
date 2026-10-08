#!/usr/bin/env bash
# Introspection SETUP: set file_rename global flag always_show_widget_link to a KNOWN value
# (0), distinct from the shipped default (1), so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set file_rename.settings always_show_widget_link 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: file_rename.settings:always_show_widget_link = 0"
