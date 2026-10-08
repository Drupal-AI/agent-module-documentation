#!/usr/bin/env bash
# Execution CLEANUP: delete the throwaway text format mathjax_task_format. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mathjax_task_format")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mathjax_task_format removed"
