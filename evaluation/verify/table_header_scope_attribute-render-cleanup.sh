#!/usr/bin/env bash
# Execution CLEANUP: delete the thsa_render text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($f = \Drupal\filter\Entity\FilterFormat::load("thsa_render")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: thsa_render removed"
