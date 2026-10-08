#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default allowed_path_prefixes=['/system/files/'].
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jwt_path_auth.config")
    ->set("allowed_path_prefixes", ["/system/files/"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt_path_auth.config allowed_path_prefixes restored to [/system/files/]"
