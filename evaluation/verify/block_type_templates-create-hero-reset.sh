#!/usr/bin/env bash
# Execution RESET: ensure the btt_hero block content type does NOT exist so verify FAILS until the
# agent creates it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if ($t = BlockContentType::load("btt_hero")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block content type btt_hero absent"
