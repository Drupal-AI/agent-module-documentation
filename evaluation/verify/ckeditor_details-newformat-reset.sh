#!/usr/bin/env bash
# Execution RESET: ensure text format ckd_new does NOT exist, so verify FAILS until the agent creates a
# CKEditor5 format with the accordion 'detail' button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckd_new")) { $e->delete(); }
  if ($f = FilterFormat::load("ckd_new")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format ckd_new absent"
