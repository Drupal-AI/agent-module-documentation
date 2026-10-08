#!/usr/bin/env bash
# Execution CLEANUP: delete the nbsp_tb editor + format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\editor\Entity\Editor::load("nbsp_tb")) { $e->delete(); }
  if ($f = \Drupal\filter\Entity\FilterFormat::load("nbsp_tb")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: nbsp_tb editor + format removed"
