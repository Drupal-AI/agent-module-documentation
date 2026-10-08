#!/usr/bin/env bash
# Execution RESET: ensure NO custom block labelled "csl_task" exists, so verify FAILS until the
# agent creates one containing a correct iframe colorbox-load link. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_task"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_content csl_task absent"
