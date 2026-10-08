#!/usr/bin/env bash
# Introspection SETUP: create a geocoder_provider entity salg_random using the offline 'random'
# geocoder plugin, so the geocode ("Geocoded input") plugin has a provider to use. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("geocoder_provider");
  if (!$s->load("salg_random")) {
    $s->create(["id"=>"salg_random","label"=>"SALG Random","plugin"=>"random","configuration"=>[]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: geocoder_provider salg_random (plugin random) created"
