#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced probe view, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v = \Drupal::entityTypeManager()->getStorage("view")->load("tome_ssc_probe"); if ($v) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view tome_ssc_probe deleted"
