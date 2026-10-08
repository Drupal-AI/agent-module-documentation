#!/usr/bin/env bash
# Introspection CLEANUP: delete the ssg_known styleguide pattern. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal\simple_styleguide\Entity\StyleguidePattern::load("ssg_known")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ssg_known removed"
