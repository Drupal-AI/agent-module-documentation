#!/usr/bin/env bash
# Restore permissionspolicy to shipped baseline: enforce enabled, NO features (emits no
# header). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("permissionspolicy.settings");
  $c->set("enforce.enable", TRUE);
  $c->set("enforce.features", []);
  $c->save();
' >/dev/null 2>&1
echo "baseline: permissionspolicy enforce.enable=true, features={}"
