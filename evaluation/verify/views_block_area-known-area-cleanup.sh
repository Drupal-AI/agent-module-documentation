#!/usr/bin/env bash
# Introspection CLEANUP: delete the vba_known view. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("vba_known")) $v->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vba_known removed"
