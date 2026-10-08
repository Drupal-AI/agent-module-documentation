#!/usr/bin/env bash
# Execution CLEANUP: delete the cdm_filter text format and its editor. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("cdm_filter")) { $e->delete(); }
  if ($f = FilterFormat::load("cdm_filter")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cdm_filter removed"
