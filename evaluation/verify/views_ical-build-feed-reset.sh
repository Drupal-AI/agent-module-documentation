#!/usr/bin/env bash
# Execution RESET (views_ical H1): delete the view 'vical_task' so the agent builds it from
# scratch. Empty state => verify FAILS (no ical feed exists). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vical_task")){$v->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vical_task removed"
