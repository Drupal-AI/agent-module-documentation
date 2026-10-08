#!/usr/bin/env bash
# Introspection CLEANUP: delete the scf_known index. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("scf_known")) { $i->delete(); }
' >/dev/null 2>&1
echo "cleanup: index scf_known removed"
