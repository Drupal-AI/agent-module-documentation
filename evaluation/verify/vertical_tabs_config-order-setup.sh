#!/usr/bin/env bash
# Introspection SETUP: set a known weight (99) for the Authoring information tab in the tab-order
# config so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset vertical_tabs_config.order vertical_tabs_config_author 99 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vertical_tabs_config.order vertical_tabs_config_author=99"
