#!/usr/bin/env bash
# Introspection CLEANUP: delete the ckq_known format + editor. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckq_known")) { $e->delete(); }
  if ($f = FilterFormat::load("ckq_known")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: ckq_known format removed"
