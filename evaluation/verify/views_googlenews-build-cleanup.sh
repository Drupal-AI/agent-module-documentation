#!/usr/bin/env bash
# Execution CLEANUP: delete the vgn_news view. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vgn_news")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vgn_news removed"
