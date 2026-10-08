#!/usr/bin/env bash
# Introspection CLEANUP: delete the eai_hidden editor + filter format created by setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("eai_hidden")) { $e->delete(); }
  if ($f = FilterFormat::load("eai_hidden")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eai_hidden editor + format removed"
