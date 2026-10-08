#!/usr/bin/env bash
# Execution RESET: remove any Last Updated date block (plugin updated_date_block) from the
# default theme, so verify FAILS until the agent places one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "updated_date_block" && $b->getTheme() === $theme) { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no updated_date_block placed in default theme"
