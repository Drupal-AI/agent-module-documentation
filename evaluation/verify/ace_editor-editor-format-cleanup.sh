#!/usr/bin/env bash
# Introspection CLEANUP: remove the ace_editor_m1 editor + text format created by setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ace_editor_m1")) { $e->delete(); }
  if ($f = FilterFormat::load("ace_editor_m1")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ace_editor_m1 editor + format removed"
