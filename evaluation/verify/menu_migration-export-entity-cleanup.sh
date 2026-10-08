#!/usr/bin/env bash
# Introspection CLEANUP: delete the mm_mig_probe Menu Export entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_migration\Entity\ExportType;
  if ($e = ExportType::load("mm_mig_probe")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mm_mig_probe removed"
