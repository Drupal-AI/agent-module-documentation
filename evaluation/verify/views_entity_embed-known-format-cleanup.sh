#!/usr/bin/env bash
# Introspection CLEANUP: remove text format vee_fmt. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("vee_fmt")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter.format.vee_fmt removed"
