#!/usr/bin/env bash
# Execution RESET: delete the tocjs_testblock block so verify FAILS until the agent places a
# toc_js_block block.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("tocjs_testblock")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block tocjs_testblock removed"
