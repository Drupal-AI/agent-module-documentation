#!/usr/bin/env bash
# Introspection SETUP: ensure node_edit_protection is enabled (baseline) so the agent can
# introspect it via drush pm:list and the installed libraries file. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install node_edit_protection -y >/dev/null 2>&1 || true
echo "setup: node_edit_protection enabled; library = node_edit_protection/node_edit_protection"
