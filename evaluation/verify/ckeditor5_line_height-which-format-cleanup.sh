#!/usr/bin/env bash
# Introspection CLEANUP: remove clh_active and clh_plain formats + editors. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["clh_active","clh_plain"] as $fmt) {
    if ($e = Editor::load($fmt)) { $e->delete(); }
    if ($f = FilterFormat::load($fmt)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: clh_active/clh_plain removed"
