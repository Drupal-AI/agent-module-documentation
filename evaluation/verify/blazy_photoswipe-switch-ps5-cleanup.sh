#!/usr/bin/env bash
# Execution CLEANUP: remove extras.photoswipe key to restore the shipped default (PhotoSwipe 4).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("blazy.settings");
  $extras = $c->get("extras") ?: [];
  unset($extras["photoswipe"]);
  $c->set("extras", $extras)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: blazy.settings extras.photoswipe removed (PhotoSwipe 4)"
