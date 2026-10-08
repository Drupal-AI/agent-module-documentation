#!/usr/bin/env bash
# Introspection CLEANUP: delete the ucp_alt test user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ex = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => "ucp_alt@example.com"]);
  if ($ex) { reset($ex)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user ucp_alt@example.com removed"
