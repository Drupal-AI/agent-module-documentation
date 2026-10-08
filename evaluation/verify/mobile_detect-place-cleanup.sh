#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->get("plugin") === "mobile_detect_status_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mobile_detect_status_block blocks removed"
