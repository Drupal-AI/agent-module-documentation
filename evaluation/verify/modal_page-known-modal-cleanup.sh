#!/usr/bin/env bash
# Introspection CLEANUP (modal_page M1): delete the mp_known modal. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\modal_page\Entity\Modal; if ($m=Modal::load("mp_known")){$m->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: modal mp_known removed"
