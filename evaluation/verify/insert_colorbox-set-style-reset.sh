#!/usr/bin/env bash
# Execution RESET (insert_colorbox): restore shipped defaults (style=image, gallery=0). verify
# expects style=large, so on this baseline it FAILS until the agent sets the colorbox image
# style to 'large'. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset insert_colorbox.config style image -y >/dev/null 2>&1
drush cset insert_colorbox.config gallery 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: insert_colorbox.config style=image gallery=0"
