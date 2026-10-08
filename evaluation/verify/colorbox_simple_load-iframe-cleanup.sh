#!/usr/bin/env bash
# Execution CLEANUP: delete the csl_task custom block. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_task"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_content csl_task removed"
