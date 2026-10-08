#!/usr/bin/env bash
# Execution RESET: ensure the eep_fmt text format does NOT exist, so verify FAILS until the agent
# creates it with the Entity Embed filter enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("eep_fmt")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter_format eep_fmt removed"
