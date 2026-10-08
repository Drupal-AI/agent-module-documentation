#!/usr/bin/env bash
# Introspection CLEANUP: remove the ckabbr_known format + editor. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_known")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format ckabbr_known removed"
