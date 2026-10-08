#!/usr/bin/env bash
# Introspection CLEANUP (tocbot): restore shipped default content_selector = '#content'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("content_selector", "#content")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tocbot.settings content_selector restored to #content"
