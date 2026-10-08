#!/usr/bin/env bash
# Introspection CLEANUP: delete the acbb_known view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("acbb_known")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view acbb_known removed"
