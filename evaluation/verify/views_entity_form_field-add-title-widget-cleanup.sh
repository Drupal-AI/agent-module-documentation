#!/usr/bin/env bash
# Execution CLEANUP: delete the veff_task view created by the matching reset. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_task")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: view veff_task removed"
