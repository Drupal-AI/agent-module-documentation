#!/usr/bin/env bash
# Introspection SETUP: ensure dxpr_builder_block is enabled and caches fresh, so the shipped
# block_content.drag_and_drop_block.default view display (body uses dxpr_builder_text) is
# discoverable live. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dxpr_builder_block -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dxpr_builder_block enabled; drag_and_drop_block display available"
