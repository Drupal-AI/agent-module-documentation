#!/usr/bin/env bash
# Execution CLEANUP: delete the is_task_heart icon term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "icons", "field_symbol_id" => "is_task_heart"]);
  foreach ($terms as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: is_task_heart icon term removed"
