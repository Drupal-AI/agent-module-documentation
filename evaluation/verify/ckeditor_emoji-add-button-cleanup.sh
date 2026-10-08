#!/usr/bin/env bash
# Execution CLEANUP: delete the ckemoji_task format + editor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\editor\Entity\Editor::load("ckemoji_task")) { $e->delete(); }
  if ($f = \Drupal\filter\Entity\FilterFormat::load("ckemoji_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckemoji_task removed"
