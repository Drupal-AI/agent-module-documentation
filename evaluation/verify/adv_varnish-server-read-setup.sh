#!/usr/bin/env bash
# Introspection SETUP: point adv_varnish at a Varnish server and enable caching+purger. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")
    ->set("general.varnish_server","http://varnish.mdtest:6081")
    ->set("general.varnish_purger",TRUE)
    ->set("available.enable_cache",TRUE)->save();
' >/dev/null 2>&1
echo "setup: adv_varnish general.varnish_server=http://varnish.mdtest:6081"
