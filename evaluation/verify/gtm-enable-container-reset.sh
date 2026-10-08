#!/usr/bin/env bash
# Execution RESET for "enable GTM with a container ID". Forces a known cleared/wrong baseline
# so verify FAILS until the agent configures it: GTM disabled and no container ID.
# The agent must set a GTM-XXXX container ID and enable the module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtm.settings")
    ->set("enable", 0)
    ->set("google-tag", "")
    ->set("admin-pages", 0)
    ->set("admin-disable", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gtm.settings cleared (enable=0, google-tag='') — agent must set a GTM-XXXX ID and enable"
