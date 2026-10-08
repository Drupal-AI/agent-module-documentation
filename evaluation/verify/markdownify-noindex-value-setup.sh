#!/usr/bin/env bash
# Introspection SETUP: set markdownify noindex to FALSE so an agent inspecting the live config
# can read back its value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset markdownify.settings noindex 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: markdownify.settings noindex=false"
