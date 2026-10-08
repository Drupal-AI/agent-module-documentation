#!/usr/bin/env bash
# Introspection SETUP: set a known VWO account id in vwo.settings so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("vwo.settings")->set("id", 654321)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vwo.settings id = 654321"
