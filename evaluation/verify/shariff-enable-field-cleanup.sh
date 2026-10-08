#!/usr/bin/env bash
# Execution CLEANUP: remove shariff_field from the Article default view display (baseline).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  if ($vd->getComponent("shariff_field")) { $vd->removeComponent("shariff_field")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: shariff_field removed from node.article default view display"
