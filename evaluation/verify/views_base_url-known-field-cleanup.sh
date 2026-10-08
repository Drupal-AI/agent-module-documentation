#!/usr/bin/env bash
# Introspection CLEANUP: delete the view created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_intro")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.views_base_url_intro removed"
