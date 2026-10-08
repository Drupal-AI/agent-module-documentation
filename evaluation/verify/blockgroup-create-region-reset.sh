#!/usr/bin/env bash
# Reset for the "create a block group that yields a new theme region" task: delete any
# block_group_content entity with id `sidebar_promo` so the agent must build it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_group_content");
  if ($e = $s->load("sidebar_promo")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_group_content 'sidebar_promo' removed"
