#!/usr/bin/env bash
# Execution CLEANUP: delete the scf_task index. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("scf_task")) { $i->delete(); }
' >/dev/null 2>&1
echo "cleanup: index scf_task removed"
