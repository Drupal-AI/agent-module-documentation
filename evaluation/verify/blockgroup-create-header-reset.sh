#!/usr/bin/env bash
# Reset for the "create a 'Header' block group" task: delete any block_group_content entity
# whose id is `header` (and any left over from a prior run) so the agent must build it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_group_content");
  if ($e = $s->load("header")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_group_content 'header' removed"
