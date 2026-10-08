#!/usr/bin/env bash
# Execution RESET: delete any consumer with client_id sopg_new_client, so verify FAILS on empty
# state until the agent creates a consumer that has the password grant enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_new_client"]);
  foreach ($cs as $c) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: consumer sopg_new_client deleted"
