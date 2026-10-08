#!/usr/bin/env bash
# Execution RESET (purge_purger_http): remove any HTTP purger settings entity that targets the
# test hostname pph-task.example.internal, so verify FAILS until the agent builds one.
# Only touches settings entities with that specific test hostname. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("purge_purger_http.settings.") as $name) {
    if ($cf->get($name)->get("hostname") === "pph-task.example.internal") {
      $cf->getEditable($name)->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed HTTP purger settings targeting pph-task.example.internal"
