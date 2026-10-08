#!/usr/bin/env bash
# Introspection CLEANUP: remove the known pool. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  if ($p = Pool::load("ccs_known_pool")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pool ccs_known_pool removed"
