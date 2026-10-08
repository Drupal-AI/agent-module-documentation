#!/usr/bin/env bash
# Execution RESET: ensure the eep_news text format does NOT exist, so verify FAILS until the agent
# creates it with BOTH the Entity Embed filter and the Align filter enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("eep_news")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter_format eep_news removed"
