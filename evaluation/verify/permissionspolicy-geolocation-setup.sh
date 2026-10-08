#!/usr/bin/env bash
# Introspection SETUP: configure geolocation to 'none' so an agent can read the policy back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("permissionspolicy.settings");
  $c->set("enforce.enable", TRUE);
  $c->set("enforce.features", ["geolocation" => ["base" => "none"]]);
  $c->save();
' >/dev/null 2>&1
echo "setup: enforce.features.geolocation.base=none"
