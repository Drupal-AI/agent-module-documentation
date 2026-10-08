#!/usr/bin/env bash
# Introspection CLEANUP: delete format ckd_known and its editor.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckd_known")) { $e->delete(); }
  if ($f = FilterFormat::load("ckd_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckd_known removed"
