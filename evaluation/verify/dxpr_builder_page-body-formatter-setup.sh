#!/usr/bin/env bash
# Introspection SETUP: ensure dxpr_builder_page is enabled and caches are fresh, so the shipped
# node.drag_and_drop_page.default view display (whose body uses the dxpr_builder_text formatter)
# is discoverable on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dxpr_builder_page -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dxpr_builder_page enabled; drag_and_drop_page display available"
