#!/usr/bin/env bash
# Execution CLEANUP: delete the vba_field_task view. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("vba_field_task")) $v->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vba_field_task removed"
