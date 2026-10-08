#!/usr/bin/env bash
# Execution RESET: remove allow_iframed_site.settings so NO path is framable (so verify, which
# expects /embed-ok to be allowed, FAILS until the agent configures it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("allow_iframed_site.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: allow_iframed_site.settings removed (no framable paths)"
