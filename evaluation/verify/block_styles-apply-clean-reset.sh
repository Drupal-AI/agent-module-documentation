#!/usr/bin/env bash
# Execution RESET: ensure NO block_styles config exists for block id 'bstyletask', so verify FAILs
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bstyletask")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: no block_styles style for bstyletask"
