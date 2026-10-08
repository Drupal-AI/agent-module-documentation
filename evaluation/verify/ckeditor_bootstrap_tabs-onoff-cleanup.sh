#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckbt_on","ckbt_off"] as $fmt) {
    if ($e = Editor::load($fmt)) { $e->delete(); }
    if ($f = FilterFormat::load($fmt)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckbt_on/ckbt_off removed"
