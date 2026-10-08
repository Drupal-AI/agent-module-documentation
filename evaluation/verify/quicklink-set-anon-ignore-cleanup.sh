#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (no_load_when_authenticated=TRUE, no ignore list).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("no_load_when_authenticated", TRUE)->set("url_patterns_to_ignore", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quicklink anon-only default restored, ignore list cleared"
