#!/usr/bin/env bash
# Reset for the "create a comment keyword-unpublish advanced action" task: delete any
# comment_unpublish_by_keyword_action config entity so the agent must build one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  foreach ($s->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "comment_unpublish_by_keyword_action") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: comment_unpublish_by_keyword_action config entities removed"
