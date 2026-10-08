#!/usr/bin/env bash
# Execution RESET: delete the view the agent must build. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("history_unread")) { $v->delete(); }
' >/dev/null 2>&1
echo "reset: view history_unread absent"
