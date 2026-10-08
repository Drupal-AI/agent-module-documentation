#!/usr/bin/env bash
# Introspection SETUP: force the current-password requirement ON (disabled=FALSE) so an inspecting agent should report it is enforced. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("nocurrent_pass.settings")->set("nocurrent_pass_disabled", FALSE)->save();' >/dev/null 2>&1
echo "nocurrent_pass.settings:nocurrent_pass_disabled set to FALSE"
