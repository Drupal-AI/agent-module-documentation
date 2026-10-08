#!/usr/bin/env bash
# Execution CLEANUP: remove user_redirect.settings (baseline = config absent). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_redirect.settings")->delete();' >/dev/null 2>&1
echo "cleanup: user_redirect.settings deleted"
