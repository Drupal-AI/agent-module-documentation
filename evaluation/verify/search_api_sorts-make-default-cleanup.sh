#!/usr/bin/env bash
# Execution CLEANUP: remove the sapisorts_display3 price sort field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  if ($e=SearchApiSortsField::load("sapisorts_display3_price")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: sapisorts_display3_price removed"
