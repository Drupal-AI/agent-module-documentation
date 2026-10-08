#!/usr/bin/env bash
# Execution reset: clear state so the "build a monthly calendar View" task starts empty.
# Deletes the target View `cv_hard_month` if it exists.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("cv_hard_month")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view cv_hard_month deleted"
