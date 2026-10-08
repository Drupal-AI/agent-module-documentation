#!/usr/bin/env bash
# Introspection SETUP: simple_block_layout_builder is enabled at baseline; the simple_block
# entity's 'layout_builder' form handler is discoverable from the entity type definition.
# No mutation needed. Exit 0.
set -uo pipefail
cd /var/www/html
echo "setup: simple_block layout_builder form handler is set by simple_block_layout_builder"
