#!/usr/bin/env bash
# Execution RESET: ensure views.view.vfp_two does NOT exist, so verify FAILS until the agent
# builds it with the specific required target filter id (nid_target). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("views.view.vfp_two");
  if (!$config->isNew()) { $config->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.vfp_two absent"
