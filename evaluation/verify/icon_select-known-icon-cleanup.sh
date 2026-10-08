#!/usr/bin/env bash
# Introspection CLEANUP: delete the is_probe_star icon term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "icons", "field_symbol_id" => "is_probe_star"]);
  foreach ($terms as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: is_probe_star icon term removed"
