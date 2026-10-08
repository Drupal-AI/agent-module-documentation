#!/usr/bin/env bash
# Introspection CLEANUP: delete the sahef_index Search API index. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("sahef_index")) { $i->delete(); }
' >/dev/null 2>&1
echo "cleanup: sahef_index removed"
