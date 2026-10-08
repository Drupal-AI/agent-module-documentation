#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("gl_com_known")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format gl_com_known removed"
