#!/usr/bin/env bash
# Introspection CLEANUP: delete the node.article.ief_table view display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.ief_table");
  if ($vd) { $vd->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.ief_table view display removed"
