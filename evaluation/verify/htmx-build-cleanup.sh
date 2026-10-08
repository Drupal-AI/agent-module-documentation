#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\htmx\Entity\HtmxBlock; if ($b = HtmxBlock::load("htmx_build")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: htmx.htmx_block.htmx_build removed"
