#!/usr/bin/env bash
# Execution RESET: force allow_multiple OFF so verify FAILS until the agent turns it on. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset commerce_wishlist.settings allow_multiple 0 -y >/dev/null 2>&1
echo "reset: commerce_wishlist.settings allow_multiple = false"
