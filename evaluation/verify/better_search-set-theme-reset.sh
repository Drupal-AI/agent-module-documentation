#!/usr/bin/env bash
# Execution RESET: force animation theme back to 0 (Background Fade) so verify FAILS until the
# agent switches it to Expand on Hover (1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("better_search.settings")->set("theme", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: better_search.settings theme=0"
