#!/usr/bin/env bash
# Execution CLEANUP: leave example_blocks enabled (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en example_blocks -y >/dev/null 2>&1
echo "cleanup: example_blocks enabled (baseline)"
