#!/usr/bin/env bash
# Execution CLEANUP: delete any social_auth_login block placed during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadByProperties(["plugin" => "social_auth_login"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_auth_login block(s) removed"
