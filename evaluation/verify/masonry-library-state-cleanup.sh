#!/usr/bin/env bash
# Introspection CLEANUP: remove the stub Masonry library created by the matching setup so the
# site returns to having neither Masonry JS library installed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/masonry web/libraries/imagesloaded
rmdir web/libraries 2>/dev/null || true
drush cr >/dev/null 2>&1
echo "cleanup: stub masonry library removed"
