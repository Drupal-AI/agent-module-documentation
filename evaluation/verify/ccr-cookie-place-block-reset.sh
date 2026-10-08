#!/usr/bin/env bash
# Execution RESET: ensure the target block is absent so verify FAILs until the agent places it.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($b=\Drupal\block\Entity\Block::load("ccr_switcher_task")){$b->delete();}' >/dev/null 2>&1
echo "reset: block ccr_switcher_task absent (target: plugin commerce_currency_resolver_cookie, region content)"
