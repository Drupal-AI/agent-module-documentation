#!/usr/bin/env bash
# Introspection CLEANUP: delete the ckeditor_media_resize_eval text format and its editor
# entity created by the matching setup, restoring the baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;
  if ($e = Editor::load("ckeditor_media_resize_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor_media_resize_eval")) { $f->delete(); }
' >/dev/null 2>&1

echo "cleanup: text format ckeditor_media_resize_eval removed"
