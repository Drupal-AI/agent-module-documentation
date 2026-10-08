#!/usr/bin/env bash
# Introspection CLEANUP: remove the known row from migmag_rollbackable_data. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("migmag_rollbackable_data")->condition("migration_plugin_id", "migmag_eval_probe")->execute();
' >/dev/null 2>&1
echo "cleanup: migmag_rollbackable_data probe row removed"
