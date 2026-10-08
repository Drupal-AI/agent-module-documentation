#!/usr/bin/env bash
# Introspection CLEANUP: delete the vat_user view created by the matching setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vat_user")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vat_user removed"
