#!/usr/bin/env bash
# Execution RESET: ensure the ssg_task styleguide pattern does NOT exist, so verify FAILS until
# the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal\simple_styleguide\Entity\StyleguidePattern::load("ssg_task")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ssg_task absent"
