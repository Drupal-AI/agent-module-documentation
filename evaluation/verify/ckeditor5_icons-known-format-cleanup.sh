#!/usr/bin/env bash
# Introspection CLEANUP: delete the `ckeditor5_icons_eval` text format and its CKEditor 5
# editor created by the matching setup, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckeditor5_icons_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor5_icons_eval")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor5_icons_eval format and editor removed"
