#!/usr/bin/env bash
# Execution CLEANUP: delete the ssg_task styleguide pattern. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal\simple_styleguide\Entity\StyleguidePattern::load("ssg_task")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ssg_task removed"
