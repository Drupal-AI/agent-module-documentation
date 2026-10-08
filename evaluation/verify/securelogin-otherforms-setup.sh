#!/usr/bin/env bash
# Introspection SETUP: add a distinctive probe form id to Secure Login's other_forms list so an
# inspecting agent can read back which extra form has been added to the secured list. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("other_forms",["securelogin_probe_form"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: securelogin.settings other_forms=[securelogin_probe_form]"
