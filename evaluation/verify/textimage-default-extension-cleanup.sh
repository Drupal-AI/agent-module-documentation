#!/usr/bin/env bash
# Introspection CLEANUP: restore Textimage default_extension to the shipped default (png).
set -uo pipefail
cd /var/www/html
drush cset textimage.settings default_extension png -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: textimage.settings default_extension=png (default)"
