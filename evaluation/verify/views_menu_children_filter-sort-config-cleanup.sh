#!/usr/bin/env bash
# Introspection CLEANUP: remove the "vmcf_test" View created by the matching setup.
# Restores baseline (no vmcf_test view). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vmcf_test")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.vmcf_test removed"
