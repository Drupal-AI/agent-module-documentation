#!/usr/bin/env bash
# Execution CLEANUP: delete the consumer sopg_new_client the agent created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_new_client"]);
  foreach ($cs as $c) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: consumer sopg_new_client removed"
