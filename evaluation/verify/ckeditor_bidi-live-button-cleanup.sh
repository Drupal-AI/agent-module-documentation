#!/usr/bin/env bash
# Introspection CLEANUP: delete the ckeditor_bidi_m1 format + editor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckeditor_bidi_m1")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor_bidi_m1")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: ckeditor_bidi_m1 format/editor removed"
