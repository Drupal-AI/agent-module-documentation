#!/usr/bin/env bash
# Execution CLEANUP (tocbot): restore shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("min_activate", "3")->set("heading_selector", "h2, h3, h4, h5, h6")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tocbot.settings min_activate/heading_selector restored to defaults"
