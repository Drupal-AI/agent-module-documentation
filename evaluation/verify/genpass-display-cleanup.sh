#!/usr/bin/env bash
# Restore genpass_display to its install default (0 = do not display).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_display", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: genpass_display restored to 0"
