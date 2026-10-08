#!/usr/bin/env bash
# Introspection CLEANUP: delete the thsa_med_empty text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($f = \Drupal\filter\Entity\FilterFormat::load("thsa_med_empty")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: thsa_med_empty removed"
