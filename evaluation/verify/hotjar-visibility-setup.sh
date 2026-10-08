#!/usr/bin/env bash
# Introspection SETUP: restrict Hotjar to only two listed pages so the agent can read the
# visibility mode + pages. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("visibility_pages",1)->set("pages","/landing\n/promo")->save();' >/dev/null 2>&1
echo "setup: hotjar.settings visibility_pages=1 (only), pages=/landing,/promo"
