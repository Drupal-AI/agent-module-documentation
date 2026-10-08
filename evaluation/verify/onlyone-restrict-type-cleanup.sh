#!/usr/bin/env bash
# Execution CLEANUP: remove onlyone_task from config and delete the content type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("onlyone.settings");
  $types = array_values(array_filter($cfg->get("onlyone_node_types") ?: [], fn($t) => $t !== "onlyone_task"));
  $cfg->set("onlyone_node_types", $types)->save();
  if ($ct=\Drupal\node\Entity\NodeType::load("onlyone_task")) { $ct->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_task unrestricted and content type removed"
