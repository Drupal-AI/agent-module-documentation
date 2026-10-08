#!/usr/bin/env bash
# Execution RESET: force requirement ON (disabled=FALSE) so verify FAILS until the agent turns it off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("nocurrent_pass.settings")->set("nocurrent_pass_disabled", FALSE)->save();' >/dev/null 2>&1
echo "nocurrent_pass.settings:nocurrent_pass_disabled set to FALSE"
