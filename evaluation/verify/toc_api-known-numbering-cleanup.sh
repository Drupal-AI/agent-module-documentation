#!/usr/bin/env bash
# Introspection CLEANUP: delete the toc_api_eval2 toc_type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  if ($t = TocType::load("toc_api_eval2")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: toc_api_eval2 removed"
