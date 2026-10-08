#!/usr/bin/env bash
# Execution RESET (also serves as cleanup): delete view fc_cal so the site is clean and verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fc_cal")) { $v->delete(); }' >/dev/null 2>&1
echo "reset: view fc_cal removed (clean)"
