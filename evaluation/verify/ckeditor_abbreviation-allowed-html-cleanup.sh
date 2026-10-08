#!/usr/bin/env bash
# Introspection CLEANUP: remove the ckabbr_html format + editor. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_html")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_html")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format ckabbr_html removed"
