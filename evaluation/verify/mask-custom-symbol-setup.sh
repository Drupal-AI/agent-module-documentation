#!/usr/bin/env bash
# Introspection SETUP: add a custom (unlocked) translation symbol 'Z' -> pattern '[a-z]' to
# mask.settings, on top of the 5 shipped locked symbols. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("mask.settings");
  $t = $cfg->get("translation") ?: [];
  $t["Z"] = ["pattern"=>"[a-z]","fallback"=>"","description"=>"maskeval lowercase","optional"=>FALSE,"recursive"=>FALSE,"locked"=>FALSE];
  $cfg->set("translation",$t)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mask.settings translation symbol Z pattern=[a-z] added"
