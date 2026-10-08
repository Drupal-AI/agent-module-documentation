#!/usr/bin/env bash
# Execution RESET: delete any Mobile Detect Status block so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->get("plugin") === "mobile_detect_status_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no mobile_detect_status_block blocks placed"
