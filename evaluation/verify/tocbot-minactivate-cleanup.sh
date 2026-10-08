#!/usr/bin/env bash
# Introspection CLEANUP (tocbot): restore shipped default min_activate = '3'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("min_activate", "3")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tocbot.settings min_activate restored to 3"
