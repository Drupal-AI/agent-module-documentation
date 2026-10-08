#!/usr/bin/env bash
# Introspection SETUP: set the page cache TTL to 900 seconds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")
    ->set("general.page_cache_maximum_age","900")->save();
' >/dev/null 2>&1
echo "setup: adv_varnish general.page_cache_maximum_age=900"
