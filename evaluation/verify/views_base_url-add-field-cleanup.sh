#!/usr/bin/env bash
# Execution CLEANUP: delete the view used by the add-field case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_task")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.views_base_url_task removed"
