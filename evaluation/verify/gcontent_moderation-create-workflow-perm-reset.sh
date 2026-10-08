#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure workflow 'gcmod_task' does NOT exist so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\workflows\Entity\Workflow;
  if ($w = Workflow::load("gcmod_task")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: workflow gcmod_task removed (permission absent)"
