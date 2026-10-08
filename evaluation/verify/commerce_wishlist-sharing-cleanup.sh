#!/usr/bin/env bash
# CLEANUP: disable anonymous sharing (shipped default is off). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset commerce_wishlist.settings allow_anonymous_sharing 0 -y >/dev/null 2>&1
echo "cleanup: commerce_wishlist.settings allow_anonymous_sharing = false"
