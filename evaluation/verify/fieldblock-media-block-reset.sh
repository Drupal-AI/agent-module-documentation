#!/usr/bin/env bash
# Execution RESET: remove the media field block the agent must build and put
# fieldblock.settings back to its baseline (deleted -> node/user/taxonomy_term fallback), so
# the fieldblock:media derivative does not exist yet and verify fails on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("fieldblock_task_media")) { $b->delete(); }
  \Drupal::configFactory()->getEditable("fieldblock.settings")->delete();
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $ids = array_keys(array_filter(\Drupal::service("plugin.manager.block")->getDefinitions(),
    fn($k) => str_starts_with($k, "fieldblock:"), ARRAY_FILTER_USE_KEY));
  sort($ids); print "reset: derivatives = " . implode(", ", $ids) . "\n";
' 2>/dev/null
exit 0
