#!/usr/bin/env bash
# Reset for the "create a keyword-unpublish advanced action" task: delete any node
# `node_unpublish_by_keyword_action` config entity so the site starts with none. The agent
# must create one. Leaves the site clean between runs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  foreach ($s->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "node_unpublish_by_keyword_action") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node_unpublish_by_keyword_action config entities removed"
