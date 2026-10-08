#!/usr/bin/env bash
# Execution CLEANUP (epk H1): delete the epk_task text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f=FilterFormat::load("epk_task")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format epk_task removed"
