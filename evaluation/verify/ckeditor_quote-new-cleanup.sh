#!/usr/bin/env bash
# Execution CLEANUP: delete ckq_new format + editor. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckq_new")) { $e->delete(); }
  if ($f = FilterFormat::load("ckq_new")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: ckq_new removed"
