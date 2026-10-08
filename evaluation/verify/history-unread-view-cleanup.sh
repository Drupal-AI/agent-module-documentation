#!/usr/bin/env bash
# Execution CLEANUP: delete the view built during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("history_unread")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: view history_unread removed"
