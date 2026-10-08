#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete the ws_eval_report View so verify FAILS until the agent
# builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("ws_eval_report")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: View ws_eval_report absent"
