#!/usr/bin/env bash
# Execution CLEANUP: delete ckd_task.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckd_task")) { $e->delete(); }
  if ($f = FilterFormat::load("ckd_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckd_task removed"
