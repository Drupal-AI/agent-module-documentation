#!/usr/bin/env bash
# Introspection CLEANUP (epk M2): delete epk_on and epk_off text formats. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["epk_on","epk_off"] as $id) { if ($f=FilterFormat::load($id)){$f->delete();} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: epk_on and epk_off removed"
