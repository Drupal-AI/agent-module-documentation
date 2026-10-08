#!/usr/bin/env bash
# Introspection CLEANUP: delete the dbug.eval_known config created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dbug.eval_known")->delete();' >/dev/null 2>&1
echo "cleanup: config dbug.eval_known deleted"
