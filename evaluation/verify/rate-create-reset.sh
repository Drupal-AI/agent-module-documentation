#!/usr/bin/env bash
# Execution RESET: ensure NO rate_widget 'rate_task' exists, so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("rate_widget")->load("rate_task");
  if ($w) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rate_widget rate_task absent"
