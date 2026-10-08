#!/usr/bin/env bash
# Execution RESET: ensure View vrss_dc_rights does NOT exist, so verify FAILS until the
# agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("vrss_dc_rights")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vrss_dc_rights absent"
