#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped baseline (min dimension 150, no image options). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("copyprevention.settings");
  $c->set("copyprevention_images_min_dimension", 150)->clear("copyprevention_images")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: copyprevention image options restored to baseline (150)"
