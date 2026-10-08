#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbt_probe")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbt_probe")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format/editor ckbt_probe removed"
