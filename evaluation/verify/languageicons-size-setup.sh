#!/usr/bin/env bash
# Introspection SETUP: set languageicons icon size to 24x18 so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings size 24x18 -y >/dev/null 2>&1
echo "setup: languageicons.settings size=24x18"
