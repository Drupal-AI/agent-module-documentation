#!/usr/bin/env bash
# Execution CLEANUP for "enable CKEditor5 Media Resize on ckeditor_media_resize_task":
# removes the throwaway text format and its editor entity so the site is left clean.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;
  if ($e = Editor::load("ckeditor_media_resize_task")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor_media_resize_task")) { $f->delete(); }
' >/dev/null 2>&1

echo "cleanup: text format ckeditor_media_resize_task removed"
