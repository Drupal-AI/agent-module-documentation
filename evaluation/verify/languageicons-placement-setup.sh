#!/usr/bin/env bash
# Introspection SETUP: set languageicons icon placement to "after" so an agent can read it
# back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set languageicons.settings placement after -y >/dev/null 2>&1
echo "setup: languageicons.settings placement=after"
