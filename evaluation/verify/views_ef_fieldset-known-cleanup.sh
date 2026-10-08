#!/usr/bin/env bash
# Introspection CLEANUP: delete the vef_test view created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("vef_test")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vef_test removed"
