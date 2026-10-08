#!/usr/bin/env bash
# Introspection CLEANUP: remove the text format + editor created by the matching setup.
# Restores baseline (no ckeditor_codemirror_eval format). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckeditor_codemirror_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor_codemirror_eval")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_codemirror_eval format/editor removed"
