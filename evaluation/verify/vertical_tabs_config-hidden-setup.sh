#!/usr/bin/env bash
# Introspection SETUP: hide the 'author' (Authoring information) tab on the Article content type
# for all roles by inserting a row into the vertical_tabs_config table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM vertical_tabs_config WHERE content_type='article' AND vertical_tab='author';" >/dev/null 2>&1
drush sqlq "INSERT INTO vertical_tabs_config (vertical_tab, content_type, hidden, roles) VALUES ('author','article',1,'[]');" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vertical_tabs_config row hides 'author' tab on article for all roles"
