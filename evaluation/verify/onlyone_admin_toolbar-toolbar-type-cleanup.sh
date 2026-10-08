#!/usr/bin/env bash
# Execution CLEANUP: clear onlyone_node_types, delete onlyone_atb_task, uninstall submodule.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_node_types", [])->save();
  if ($ct=\Drupal\node\Entity\NodeType::load("onlyone_atb_task")) { $ct->delete(); }
' >/dev/null 2>&1
drush pmu onlyone_admin_toolbar -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_atb_task + config removed, onlyone_admin_toolbar uninstalled"
