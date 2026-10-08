#!/usr/bin/env bash
# Introspection CLEANUP: remove the QCU currency. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\currency\Entity\Currency; if ($c = Currency::load("QCU")) { $c->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: currency QCU removed"
