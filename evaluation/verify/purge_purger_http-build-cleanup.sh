#!/usr/bin/env bash
# Execution CLEANUP (purge_purger_http): same as reset - drop any settings entity targeting the
# test hostname pph-task.example.internal. Idempotent. Exit 0.
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
echo "cleanup: removed HTTP purger settings targeting pph-task.example.internal"
