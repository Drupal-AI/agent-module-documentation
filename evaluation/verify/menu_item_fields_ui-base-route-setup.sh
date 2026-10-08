#!/usr/bin/env bash
# Introspection SETUP: menu_item_fields_ui is enabled at baseline; the field_ui_base_route is
# discoverable from the menu_link_content entity type definition. No mutation needed. Exit 0.
set -uo pipefail
cd /var/www/html
echo "setup: menu_link_content.field_ui_base_route is set by menu_item_fields_ui (entity.menu.collection)"
