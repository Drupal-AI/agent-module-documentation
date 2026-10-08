#!/usr/bin/env bash
# Introspection CLEANUP: delete view vab_probe2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vab_probe2")) $v->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vab_probe2 removed"
