#!/usr/bin/env bash
# Execution CLEANUP: remove any updated_date_block from the default theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "updated_date_block" && $b->getTheme() === $theme) { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: updated_date_block(s) removed from default theme"
