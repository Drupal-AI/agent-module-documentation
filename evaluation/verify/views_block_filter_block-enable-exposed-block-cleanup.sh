#!/usr/bin/env bash
# Execution CLEANUP: delete the vbfb_task view created by the matching reset. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_task")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vbfb_task removed"
