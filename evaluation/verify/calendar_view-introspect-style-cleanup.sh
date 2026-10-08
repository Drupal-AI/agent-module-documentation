#!/usr/bin/env bash
# Introspection cleanup: remove the known View installed by the setup script.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("cv_eval_agenda")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view cv_eval_agenda removed"
