#!/usr/bin/env bash
# Execution CLEANUP: remove the clh_opts format + editor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("clh_opts")) { $e->delete(); }
  if ($f = FilterFormat::load("clh_opts")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: clh_opts removed"
