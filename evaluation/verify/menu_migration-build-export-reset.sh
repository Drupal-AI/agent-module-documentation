#!/usr/bin/env bash
# Execution RESET: ensure the mm_mig_export Menu Export entity does NOT exist, so verify FAILS
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_migration\Entity\ExportType;
  if ($e = ExportType::load("mm_mig_export")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mm_mig_export absent"
