#!/usr/bin/env bash
# Introspection CLEANUP: delete the nbsp_tbfmt editor + format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\editor\Entity\Editor::load("nbsp_tbfmt")) { $e->delete(); }
  if ($f = \Drupal\filter\Entity\FilterFormat::load("nbsp_tbfmt")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: nbsp_tbfmt editor + format removed"
