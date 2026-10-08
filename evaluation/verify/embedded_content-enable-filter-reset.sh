#!/usr/bin/env bash
# Execution RESET: ensure the text format 'ec_task_format' does NOT exist, so verify FAILs until the
# agent creates it with the embedded_content filter enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ec_task_format")) { $f->delete(); }
' >/dev/null 2>&1
echo "reset: text format ec_task_format absent"
