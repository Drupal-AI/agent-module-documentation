#!/usr/bin/env bash
# Execution RESET: delete the node.article.ief_table view display so verify FAILS until the agent
# creates and enables it with at least one column.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.ief_table");
  if ($vd) { $vd->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.ief_table view display removed"
