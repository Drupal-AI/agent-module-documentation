#!/usr/bin/env bash
# Execution CLEANUP: delete the iv_task text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($f = \Drupal::entityTypeManager()->getStorage("filter_format")->load("iv_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format iv_task removed"
