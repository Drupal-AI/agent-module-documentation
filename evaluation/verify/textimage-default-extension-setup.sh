#!/usr/bin/env bash
# Introspection SETUP: set Textimage's default output extension to a known value (jpg),
# so an inspecting agent can read it back from textimage.settings. Baseline is png.
set -uo pipefail
cd /var/www/html
drush cset textimage.settings default_extension jpg -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: textimage.settings default_extension=jpg"
