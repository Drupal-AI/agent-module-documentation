#!/usr/bin/env bash
# Execution RESET for the "place a dark twitter_block timeline" task: delete EVERY
# block instance using the twitter_block plugin so the site starts from empty state
# (the verify must FAIL before the agent builds anything). Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "twitter_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all twitter_block block instances removed"
