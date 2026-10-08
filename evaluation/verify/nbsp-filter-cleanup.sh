#!/usr/bin/env bash
# Introspection CLEANUP: delete the nbsp_eval text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($f = \Drupal\filter\Entity\FilterFormat::load("nbsp_eval")) { $f->delete(); }' >/dev/null 2>&1
echo "cleanup: filter.format.nbsp_eval removed"
