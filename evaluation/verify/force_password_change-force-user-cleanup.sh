#!/usr/bin/env bash
# Execution CLEANUP: delete the fpc_task@example.com test user (clears its user.data). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ex = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => "fpc_task@example.com"]);
  if ($ex) { reset($ex)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user fpc_task@example.com removed"
