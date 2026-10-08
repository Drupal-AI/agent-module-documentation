#!/usr/bin/env bash
# Execution CLEANUP: delete the ckbsgrid_plain text format and its editor created by the
# matching reset, leaving the site at baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbsgrid_plain")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbsgrid_plain")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format ckbsgrid_plain removed"
exit 0
