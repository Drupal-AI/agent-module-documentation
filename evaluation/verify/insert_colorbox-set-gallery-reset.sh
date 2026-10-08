#!/usr/bin/env bash
# Execution RESET (insert_colorbox): restore shipped defaults (style=image, gallery=0). verify
# expects gallery=post, so on this baseline it FAILS until the agent sets a per-post gallery. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset insert_colorbox.config style image -y >/dev/null 2>&1
drush cset insert_colorbox.config gallery 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: insert_colorbox.config style=image gallery=0 (no gallery)"
