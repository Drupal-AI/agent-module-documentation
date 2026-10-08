#!/usr/bin/env bash
# Execution RESET (epk H2): delete text format 'epk_new' so the agent must create it with the
# Empty Paragraph filter enabled. Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f=FilterFormat::load("epk_new")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format epk_new removed"
