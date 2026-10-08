#!/usr/bin/env bash
# Execution RESET: ensure the toc_api_numbered toc_type does NOT exist, so verify FAILS until
# the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  if ($t = TocType::load("toc_api_numbered")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toc_api_numbered absent"
