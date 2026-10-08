#!/usr/bin/env bash
# Introspection CLEANUP: remove the ck5fs_eval2 text format and its editor. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($ed = Editor::load("ck5fs_eval2")) { $ed->delete(); }
  if ($fmt = FilterFormat::load("ck5fs_eval2")) { $fmt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ck5fs_eval2 format and editor removed"
