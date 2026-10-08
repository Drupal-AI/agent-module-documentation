#!/usr/bin/env bash
# Introspection CLEANUP: delete the two text formats (and their CKEditor 5 editors) created by
# the matching setup, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckeditor5_icons_alpha", "ckeditor5_icons_beta"] as $id) {
    if ($e = Editor::load($id)) { $e->delete(); }
    if ($f = FilterFormat::load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor5_icons_alpha and ckeditor5_icons_beta removed"
