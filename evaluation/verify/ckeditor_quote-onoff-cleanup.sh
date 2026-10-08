#!/usr/bin/env bash
# Introspection CLEANUP: delete ckq_on and ckq_off formats + editors. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckq_on","ckq_off"] as $fmt) {
    if ($e = Editor::load($fmt)) { $e->delete(); }
    if ($f = FilterFormat::load($fmt)) { $f->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: ckq_on and ckq_off removed"
