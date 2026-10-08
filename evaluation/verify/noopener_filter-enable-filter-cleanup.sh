#!/usr/bin/env bash
# Execution CLEANUP: delete the noopener_hard_fmt text format created by reset. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("noopener_hard_fmt")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format noopener_hard_fmt removed"
