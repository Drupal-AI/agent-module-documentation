#!/usr/bin/env bash
# Introspection CLEANUP: nothing persistent was created by the matching setup; this simply
# re-asserts the baseline (no stub libraries). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/masonry web/libraries/imagesloaded
rmdir web/libraries 2>/dev/null || true
drush cr >/dev/null 2>&1
echo "cleanup: baseline restored (no stub libraries)"
