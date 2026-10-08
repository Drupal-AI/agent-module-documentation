#!/usr/bin/env bash
# Execution RESET: ensure the View "vmcf_task" does NOT exist, so verify FAILS until the
# agent builds it with the module's menu-children argument handler. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vmcf_task")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.vmcf_task removed (empty state)"
