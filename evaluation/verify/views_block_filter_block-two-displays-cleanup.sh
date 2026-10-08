#!/usr/bin/env bash
# Introspection CLEANUP: delete the vbfb_two view created by the matching setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_two")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vbfb_two removed"
