#!/usr/bin/env bash
# Execution RESET: ensure the bulk action that sets nodes to 'published' does NOT exist, so verify
# FAILS until the agent creates it. Running reset again after the task = cleanup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if ($a = Action::load("state_change__node__published")) { $a->delete(); }
' >/dev/null 2>&1 || true
echo "reset: action state_change__node__published absent"
