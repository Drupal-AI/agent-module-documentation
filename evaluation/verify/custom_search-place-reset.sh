#!/usr/bin/env bash
# HARD execution RESET: remove any custom_search_task block so verify FAILs until the agent
# places a Custom Search block. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b=Block::load("custom_search_task")) $b->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no custom_search_task block"
