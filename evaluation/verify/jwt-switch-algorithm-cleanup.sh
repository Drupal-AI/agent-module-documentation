#!/usr/bin/env bash
# Execution CLEANUP: delete jwt.config and any jwt_task_alg / jwt_task_alg512 keys. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  \Drupal::configFactory()->getEditable("jwt.config")->delete();
  foreach (["jwt_task_alg","jwt_task_alg512"] as $id) { if ($k = Key::load($id)) { $k->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt.config removed, jwt_task_alg* deleted"
