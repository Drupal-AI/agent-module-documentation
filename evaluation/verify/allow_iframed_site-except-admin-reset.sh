#!/usr/bin/env bash
# Execution RESET: remove allow_iframed_site.settings so verify (which expects negate ON excluding
# /admin) FAILS until the agent configures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("allow_iframed_site.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: allow_iframed_site.settings removed"
