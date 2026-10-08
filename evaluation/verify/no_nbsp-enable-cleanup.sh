#!/usr/bin/env bash
# Execution CLEANUP: delete the no_nbsp_hard text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("no_nbsp_hard")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format no_nbsp_hard removed"
