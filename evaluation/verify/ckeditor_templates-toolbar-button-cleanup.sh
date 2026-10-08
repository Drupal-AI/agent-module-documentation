#!/usr/bin/env bash
# Execution CLEANUP: delete the ckeditor_templates_eval format/editor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckeditor_templates_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckeditor_templates_eval")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_templates_eval format removed"
