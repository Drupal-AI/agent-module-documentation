#!/usr/bin/env bash
# Reset for the "create an assign-author advanced action" task: delete any
# node_assign_owner_action config entity so the agent must build one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  foreach ($s->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "node_assign_owner_action") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node_assign_owner_action config entities removed"
