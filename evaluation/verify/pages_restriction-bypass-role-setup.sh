#!/usr/bin/env bash
# Introspection SETUP: set a known bypass role (administrator) in pages_restriction.settings so
# an agent can read back which role bypasses restrictions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pages_restriction.settings");
  $c->set("bypass_role", ["administrator" => "administrator"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pages_restriction bypass_role = administrator"
