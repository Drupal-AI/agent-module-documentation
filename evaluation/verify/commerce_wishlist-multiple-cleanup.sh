#!/usr/bin/env bash
# CLEANUP: restore shipped default (allow_multiple false). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset commerce_wishlist.settings allow_multiple 0 -y >/dev/null 2>&1
echo "cleanup: commerce_wishlist.settings allow_multiple = false"
