#!/usr/bin/env bash
# Introspection CLEANUP: remove both text formats created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckeditor_codemirror_on", "ckeditor_codemirror_off"] as $id) {
    if ($e = Editor::load($id)) { $e->delete(); }
    if ($f = FilterFormat::load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_codemirror_on / ckeditor_codemirror_off removed"
