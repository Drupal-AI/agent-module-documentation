#!/usr/bin/env bash
# Introspection CLEANUP: restore coi.settings message.template to its shipped default. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings message.template 'This field is overridden by environment specific configuration.' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: coi.settings message.template restored to default"
