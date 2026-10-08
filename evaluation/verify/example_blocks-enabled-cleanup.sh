#!/usr/bin/env bash
# Introspection CLEANUP: leave example_blocks enabled (baseline for this campaign). Idempotent.
set -uo pipefail
cd /var/www/html
drush en example_blocks -y >/dev/null 2>&1
echo "cleanup: example_blocks enabled (baseline)"
