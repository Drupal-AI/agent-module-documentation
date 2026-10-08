#!/usr/bin/env bash
# Introspection SETUP: put a KNOWN value on the live site so an inspecting agent can read
# it back. Sets noreqnewpass.settings_form:noreqnewpass_disable to TRUE (password-reset
# flow disabled). Idempotent. Rebuilds routes so the route-access change applies. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreqnewpass.settings_form")
    ->set("noreqnewpass_disable", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: noreqnewpass.settings_form:noreqnewpass_disable = TRUE"
