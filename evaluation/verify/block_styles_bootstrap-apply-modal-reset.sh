#!/usr/bin/env bash
# Execution RESET: ensure NO block_styles config exists for block 'bsboot_task', so verify FAILs until
# the agent applies the Bootstrap Modal style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bsboot_task")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: no block_styles style for bsboot_task"
