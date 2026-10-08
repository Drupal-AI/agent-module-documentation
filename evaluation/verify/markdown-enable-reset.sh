#!/usr/bin/env bash
# Execution RESET: ensure text format md_task does NOT exist, so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("md_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format md_task absent"
