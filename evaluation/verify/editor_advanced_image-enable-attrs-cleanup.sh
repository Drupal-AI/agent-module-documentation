#!/usr/bin/env bash
# Execution CLEANUP: delete the eai_task editor + filter format. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("eai_task")) { $e->delete(); }
  if ($f = FilterFormat::load("eai_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eai_task editor + format removed"
