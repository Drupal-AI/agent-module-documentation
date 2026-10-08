#!/usr/bin/env bash
# Execution RESET for the "configure forum.settings" task: restore forum.settings to its
# install defaults so the target values are NOT present before the agent runs.
# Defaults: topics.page_limit=25, topics.hot_threshold=15, topics.order=1.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("forum.settings")
    ->set("topics.page_limit", 25)
    ->set("topics.hot_threshold", 15)
    ->set("topics.order", 1)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: forum.settings topics.* restored to defaults (page_limit=25, hot_threshold=15, order=1)"
