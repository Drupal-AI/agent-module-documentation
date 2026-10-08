#!/usr/bin/env bash
# Execution CLEANUP: delete jwt.config and jwt_task_hmac Key to restore baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  \Drupal::configFactory()->getEditable("jwt.config")->delete();
  if ($k = Key::load("jwt_task_hmac")) { $k->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt.config removed, jwt_task_hmac deleted"
