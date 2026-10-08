#!/usr/bin/env bash
# Introspection CLEANUP: delete view fcl_events. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fcl_events")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view fcl_events removed"
