#!/usr/bin/env bash
# Introspection CLEANUP (views_url_path_arguments): remove vupa_intro_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vupa_intro_view")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vupa_intro_view removed"
