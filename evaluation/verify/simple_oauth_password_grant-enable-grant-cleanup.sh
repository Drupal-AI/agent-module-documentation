#!/usr/bin/env bash
# Execution CLEANUP: delete the SOPG task consumer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_task_client"]);
  foreach ($cs as $c) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: consumer sopg_task_client removed"
