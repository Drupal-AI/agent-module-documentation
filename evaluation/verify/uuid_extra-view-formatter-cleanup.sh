#!/usr/bin/env bash
# Execution CLEANUP (uuid_extra): remove the uuid component from the Article view display. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd->getComponent("uuid")) { $vd->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: uuid removed from node.article default view display"
