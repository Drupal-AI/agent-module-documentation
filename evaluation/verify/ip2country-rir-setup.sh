#!/usr/bin/env bash
# Introspection SETUP: set a known non-default RIR + update interval in ip2country.settings so
# an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("rir", "ripe")->set("update_interval", 86400)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ip2country.settings rir=ripe update_interval=86400"
