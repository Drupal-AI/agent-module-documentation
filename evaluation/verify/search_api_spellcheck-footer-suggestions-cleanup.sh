#!/usr/bin/env bash
# Introspection CLEANUP: delete the sais_footer view. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("sais_footer")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view sais_footer removed"
