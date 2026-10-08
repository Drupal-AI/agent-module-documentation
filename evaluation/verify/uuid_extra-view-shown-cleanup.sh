#!/usr/bin/env bash
# Introspection CLEANUP (uuid_extra): remove the uuid component from the Article view display,
# restoring the baseline (UUID hidden on rendered output). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd->getComponent("uuid")) { $vd->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: uuid removed from node.article default view display"
