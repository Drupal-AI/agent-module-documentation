#!/usr/bin/env bash
# Execution CLEANUP: remove the name_hardfmt name_format entity. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\name\Entity\NameFormat;
  if ($e = NameFormat::load("name_hardfmt")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: name.name_format.name_hardfmt removed"
