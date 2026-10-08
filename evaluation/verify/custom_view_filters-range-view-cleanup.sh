#!/usr/bin/env bash
# Introspection CLEANUP: delete cvf_range_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("cvf_range_view")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cvf_range_view removed"
