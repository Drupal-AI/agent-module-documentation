#!/usr/bin/env bash
# Introspection CLEANUP: delete the text format and editor created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbsgrid_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbsgrid_eval")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format ckbsgrid_eval removed"
exit 0
