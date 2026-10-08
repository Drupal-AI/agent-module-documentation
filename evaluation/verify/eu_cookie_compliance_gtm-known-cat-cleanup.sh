#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  if ($c = CookieCategory::load("eucc_analytics")) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eucc_analytics removed"
