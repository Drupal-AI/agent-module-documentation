#!/usr/bin/env bash
# Introspection SETUP: set coi.settings override_behavior to 'noaccess' (non-default) so the
# agent must inspect the live config to report the active behavior. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set coi.settings override_behavior noaccess -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: coi.settings override_behavior=noaccess"
