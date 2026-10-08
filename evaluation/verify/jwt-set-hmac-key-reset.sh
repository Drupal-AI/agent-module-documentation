#!/usr/bin/env bash
# Execution RESET: clear JWT signing configuration so verify FAILS on empty state.
# Deletes jwt.config (baseline: object does not exist) and the jwt_task_hmac Key.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  \Drupal::configFactory()->getEditable("jwt.config")->delete();
  if ($k = Key::load("jwt_task_hmac")) { $k->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no jwt.config, no jwt_task_hmac key"
