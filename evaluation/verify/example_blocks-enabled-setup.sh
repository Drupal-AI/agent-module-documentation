#!/usr/bin/env bash
# Introspection SETUP: ensure the example_blocks module is enabled so an agent can inspect the
# blocks it registers (via its example_blocks.gutenberg.yml) on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en example_blocks -y >/dev/null 2>&1
echo "setup: example_blocks enabled"
