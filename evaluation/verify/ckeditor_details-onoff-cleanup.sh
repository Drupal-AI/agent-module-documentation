#!/usr/bin/env bash
# Introspection CLEANUP: delete ckd_on and ckd_off.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach(["ckd_on","ckd_off"] as $id){ if ($e = Editor::load($id)) { $e->delete(); } if ($f = FilterFormat::load($id)) { $f->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckd_on and ckd_off removed"
