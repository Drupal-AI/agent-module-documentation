#!/usr/bin/env bash
# Introspection SETUP: set Blazy's Extras so PhotoSwipe 5 is the active major
# (blazy.settings extras.photoswipe = 5). Agent must read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("blazy.settings");
  $extras = $c->get("extras") ?: [];
  $extras["photoswipe"] = 5;
  $c->set("extras", $extras)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: blazy.settings extras.photoswipe=5 (PhotoSwipe 5 active)"
