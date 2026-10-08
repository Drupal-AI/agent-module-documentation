#!/usr/bin/env bash
# Execution RESET (tocbot): restore shipped defaults for min_activate ('3') and heading_selector
# ('h2, h3, h4, h5, h6') so verify FAILS until the agent applies the requested change. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("min_activate", "3")->set("heading_selector", "h2, h3, h4, h5, h6")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tocbot.settings min_activate=3, heading_selector='h2, h3, h4, h5, h6'"
