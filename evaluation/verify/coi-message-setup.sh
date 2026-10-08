#!/usr/bin/env bash
# Introspection SETUP: set a distinctive coi.settings message.template so the agent must read
# the live config to report the override message text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings message.template 'COI known override message' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: coi.settings message.template='COI known override message'"
