#!/usr/bin/env bash
# Execution RESET for "build a Google News feed view": ensure view vgn_news does NOT exist, so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vgn_news")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vgn_news absent"
