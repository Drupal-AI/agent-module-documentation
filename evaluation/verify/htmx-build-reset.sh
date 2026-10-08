#!/usr/bin/env bash
# Execution RESET: ensure no htmx_build HTMX Block exists (so verify FAILS until built). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\htmx\Entity\HtmxBlock; if ($b = HtmxBlock::load("htmx_build")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: htmx.htmx_block.htmx_build absent"
