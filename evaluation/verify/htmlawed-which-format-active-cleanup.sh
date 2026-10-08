#!/usr/bin/env bash
# Cleanup: delete htmlawed_on and htmlawed_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["htmlawed_on","htmlawed_off"] as $id) { if ($f = FilterFormat::load($id)) { $f->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: htmlawed_on/htmlawed_off removed"
