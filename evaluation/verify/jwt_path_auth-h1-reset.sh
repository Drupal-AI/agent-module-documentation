#!/usr/bin/env bash
# Execution RESET: force baseline allowed_path_prefixes=['/system/files/']. The task asks the
# agent to also add '/jwtpa-task/', so verify must FAIL against this reset state. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jwt_path_auth.config")
    ->set("allowed_path_prefixes", ["/system/files/"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jwt_path_auth.config allowed_path_prefixes=[/system/files/] (baseline)"
