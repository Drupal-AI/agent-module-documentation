#!/usr/bin/env bash
# Introspection SETUP: ensure the onlyone_admin_toolbar submodule is installed (pulls in
# admin_toolbar_tools) so an agent can confirm it is enabled and name its service. Idempotent.
set -uo pipefail
cd /var/www/html
drush en onlyone_admin_toolbar -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: onlyone_admin_toolbar enabled (service onlyone.admin_toolbar available)"
