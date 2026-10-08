#!/usr/bin/env bash
# Introspection CLEANUP: delete the nrf_known text format created by setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("nrf_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format nrf_known removed"
