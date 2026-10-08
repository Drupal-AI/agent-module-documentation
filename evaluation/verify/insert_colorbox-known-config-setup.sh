#!/usr/bin/env bash
# Introspection SETUP (insert_colorbox): write a known insert_colorbox.config (style=thumbnail,
# gallery=page) so an agent can read back the gallery mode / colorbox image style. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset insert_colorbox.config style thumbnail -y >/dev/null 2>&1
drush cset insert_colorbox.config gallery page -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: insert_colorbox.config style=thumbnail gallery=page"
