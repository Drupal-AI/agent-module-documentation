#!/usr/bin/env bash
# Introspection SETUP: route simple_block_layout_builder.edit_block is registered at baseline;
# discoverable from the router. No mutation needed. Exit 0.
set -uo pipefail
cd /var/www/html
echo "setup: route simple_block_layout_builder.edit_block is registered by the submodule"
