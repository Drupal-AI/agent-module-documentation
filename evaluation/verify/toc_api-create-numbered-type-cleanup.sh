#!/usr/bin/env bash
# Execution CLEANUP: remove the toc_api_numbered toc_type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  if ($t = TocType::load("toc_api_numbered")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: toc_api_numbered removed"
