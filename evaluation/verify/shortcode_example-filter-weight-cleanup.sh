#!/usr/bin/env bash
# Introspection CLEANUP: delete the sce_eval text format created by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sce_eval")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sce_eval removed"
