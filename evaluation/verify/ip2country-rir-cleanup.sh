#!/usr/bin/env bash
# Introspection CLEANUP: restore ip2country.settings rir/update_interval to shipped defaults
# (all / 604800). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("rir", "all")->set("update_interval", 604800)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ip2country.settings rir/update_interval restored to defaults"
