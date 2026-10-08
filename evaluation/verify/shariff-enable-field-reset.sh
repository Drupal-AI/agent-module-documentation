#!/usr/bin/env bash
# Execution RESET: ensure the Shariff extra display field (shariff_field) is NOT shown on the
# Article default view display, so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  if ($vd->getComponent("shariff_field")) { $vd->removeComponent("shariff_field")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: shariff_field removed from node.article default view display"
