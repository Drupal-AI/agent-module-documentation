#!/usr/bin/env bash
# Introspection CLEANUP (insert_colorbox): restore shipped defaults (style=image, gallery=0). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset insert_colorbox.config style image -y >/dev/null 2>&1
drush cset insert_colorbox.config gallery 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: insert_colorbox.config restored to defaults (style=image, gallery=0)"
