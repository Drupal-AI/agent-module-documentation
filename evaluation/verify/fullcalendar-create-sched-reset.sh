#!/usr/bin/env bash
# Execution RESET (also serves as cleanup): delete view fc_sched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fc_sched")) { $v->delete(); }' >/dev/null 2>&1
echo "reset: view fc_sched removed (clean)"
