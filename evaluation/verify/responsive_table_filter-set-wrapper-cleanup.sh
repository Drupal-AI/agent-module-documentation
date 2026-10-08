#!/usr/bin/env bash
# Execution CLEANUP: delete the rtf_wrap text format. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("rtf_wrap")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format rtf_wrap removed"
