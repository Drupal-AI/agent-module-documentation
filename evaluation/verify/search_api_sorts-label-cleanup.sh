#!/usr/bin/env bash
# Introspection CLEANUP: remove the sort field created by search_api_sorts-label-setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  if ($e=SearchApiSortsField::load("sapisorts_display2_created")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: sapisorts_display2_created removed"
