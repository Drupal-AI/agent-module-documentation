#!/usr/bin/env bash
# Execution RESET: remove user_redirect.settings so no login redirect exists (verify FAILS
# until the agent configures it). Baseline = config absent. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_redirect.settings")->delete();' >/dev/null 2>&1
echo "reset: user_redirect.settings deleted (no login redirect configured)"
