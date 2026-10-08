#!/usr/bin/env bash
# Introspection CLEANUP: restore file_rename global flag to the shipped default (1).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set file_rename.settings always_show_widget_link 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: file_rename.settings:always_show_widget_link restored to 1 (default)"
