#!/usr/bin/env bash
# Introspection CLEANUP: delete webform weh_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\webform\Entity\Webform; if ($w = Webform::load("weh_known")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform weh_known removed"
