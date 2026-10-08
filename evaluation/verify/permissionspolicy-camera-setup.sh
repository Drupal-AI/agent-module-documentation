#!/usr/bin/env bash
# Introspection SETUP: configure camera to 'self' so an agent can read the policy back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("permissionspolicy.settings");
  $c->set("enforce.enable", TRUE);
  $c->set("enforce.features", ["camera" => ["base" => "self"]]);
  $c->save();
' >/dev/null 2>&1
echo "setup: enforce.features.camera.base=self"
