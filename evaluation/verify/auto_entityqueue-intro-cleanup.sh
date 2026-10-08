#!/usr/bin/env bash
# Introspection CLEANUP (auto_entityqueue): remove entityqueue aeq_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("aeq_known")) { $q->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: aeq_known removed"
