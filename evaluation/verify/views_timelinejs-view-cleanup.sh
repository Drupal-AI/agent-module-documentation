#!/usr/bin/env bash
# Introspection CLEANUP: delete the vtl_med_view View created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vtl_med_view")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: View vtl_med_view removed"
