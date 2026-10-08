#!/usr/bin/env bash
# Introspection CLEANUP: delete the ckemoji_known format + editor created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckemoji_known")) { $e->delete(); }
  if ($f = FilterFormat::load("ckemoji_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckemoji_known format removed"
