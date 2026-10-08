#!/usr/bin/env bash
# Execution CLEANUP: delete the vtl_hard_view View created by reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vtl_hard_view")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: View vtl_hard_view removed"
