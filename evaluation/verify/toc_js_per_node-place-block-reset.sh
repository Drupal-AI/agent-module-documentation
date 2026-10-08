#!/usr/bin/env bash
# Execution RESET: delete block tocjspn_testblock so verify FAILS until the agent places a
# toc_js_per_node_block.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("tocjspn_testblock")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block tocjspn_testblock removed"
