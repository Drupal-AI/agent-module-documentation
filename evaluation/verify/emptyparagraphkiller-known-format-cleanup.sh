#!/usr/bin/env bash
# Introspection CLEANUP (epk M1): delete the epk_known text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f=FilterFormat::load("epk_known")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format epk_known removed"
