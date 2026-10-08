#!/usr/bin/env bash
# Execution CLEANUP: remove the ace_editor_h1 editor + format. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ace_editor_h1")) { $e->delete(); }
  if ($f = FilterFormat::load("ace_editor_h1")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ace_editor_h1 editor + format removed"
