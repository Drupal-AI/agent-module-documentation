#!/usr/bin/env bash
# Introspection SETUP: ensure jquery_ui_sortable is enabled so the agent can inspect which module
# supplies the vendored sortable JS in the resolved library. Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:install jquery_ui_sortable -y >/dev/null 2>&1 || drush en jquery_ui_sortable -y >/dev/null 2>&1
echo "setup: jquery_ui_sortable enabled"
