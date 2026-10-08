#!/usr/bin/env bash
# Execution RESET: ensure NO mailing_list_subscribe block mlist_side exists, so verify FAILS until
# the agent places one in the theme's sidebar region wired to a list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("mlist_side")) { $b->delete(); }' >/dev/null 2>&1
echo "reset: block mlist_side absent"
