#!/usr/bin/env bash
# HARD execution RESET: ensure stripe_examples enabled and remove any stripe_ex_task block so
# verify FAILs until the agent places the example checkout block. Exit 0.
set -uo pipefail
cd /var/www/html
drush en stripe_examples -y >/dev/null 2>&1
drush php:eval 'use Drupal\block\Entity\Block; if ($b=Block::load("stripe_ex_task")) $b->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: stripe_examples enabled, no stripe_ex_task block"
