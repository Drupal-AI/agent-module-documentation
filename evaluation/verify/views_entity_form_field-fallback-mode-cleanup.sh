#!/usr/bin/env bash
# Introspection CLEANUP: delete the veff_fallback view created by the matching setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_fallback")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: view veff_fallback removed"
