#!/usr/bin/env bash
# Execution CLEANUP: remove the clh_task format + editor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("clh_task")) { $e->delete(); }
  if ($f = FilterFormat::load("clh_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: clh_task removed"
