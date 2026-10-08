#!/usr/bin/env bash
# Execution CLEANUP: delete the sahef_task Search API index. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("sahef_task")) { $i->delete(); }
' >/dev/null 2>&1
echo "cleanup: sahef_task removed"
