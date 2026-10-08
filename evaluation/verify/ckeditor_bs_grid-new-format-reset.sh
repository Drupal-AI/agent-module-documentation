#!/usr/bin/env bash
# Execution RESET: delete the text format + editor the agent must create (ckbsgrid_task) so
# verify fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbsgrid_task")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbsgrid_task")) { $f->delete(); }
  print "reset: ckbsgrid_task present=" . (FilterFormat::load("ckbsgrid_task") ? "yes" : "no") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
