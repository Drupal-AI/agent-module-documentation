#!/usr/bin/env bash
# Introspection SETUP: enable multiple wishlists per customer so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset commerce_wishlist.settings allow_multiple true -y >/dev/null 2>&1
echo "setup: commerce_wishlist.settings allow_multiple = true"
