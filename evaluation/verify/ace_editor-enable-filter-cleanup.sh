#!/usr/bin/env bash
# Execution CLEANUP: remove the ace_editor_h2 text format. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ace_editor_h2")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ace_editor_h2 format removed"
