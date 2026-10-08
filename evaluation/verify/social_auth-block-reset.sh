#!/usr/bin/env bash
# Execution RESET: delete any placed "Social Auth Login" (social_auth_login) block so verify
# FAILS until the agent places one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadByProperties(["plugin" => "social_auth_login"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no social_auth_login block placed"
