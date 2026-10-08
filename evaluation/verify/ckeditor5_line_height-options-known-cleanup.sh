#!/usr/bin/env bash
# Introspection CLEANUP: remove the clh_known format + editor created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("clh_known")) { $e->delete(); }
  if ($f = FilterFormat::load("clh_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: clh_known removed"
