#!/usr/bin/env bash
# Introspection CLEANUP: remove ibw_probe_fmt.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("ibw_probe_fmt")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ibw_probe_fmt removed"
