#!/usr/bin/env bash
# Execution RESET: force PhotoSwipe major to the default (PhotoSwipe 4) by removing the
# extras.photoswipe key, so verify FAILS until the agent switches to PhotoSwipe 5.
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
echo "reset: blazy.settings extras.photoswipe removed (PhotoSwipe 4)"
