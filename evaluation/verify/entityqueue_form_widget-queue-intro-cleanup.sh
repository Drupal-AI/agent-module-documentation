#!/usr/bin/env bash
# Introspection CLEANUP: delete the eqfw_intro queue (and its subqueue). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("eqfw_intro")) { $q->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eqfw_intro removed"
