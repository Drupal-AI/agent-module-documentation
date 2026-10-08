#!/usr/bin/env bash
# Introspection CLEANUP: delete the fpc_known@example.com test user (also clears its user.data).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ex = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => "fpc_known@example.com"]);
  if ($ex) { reset($ex)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user fpc_known@example.com removed"
