#!/usr/bin/env bash
# Introspection SETUP: turn on sitewide token support and restrict which CAS attributes are
# exposed as tokens, so an agent can read the live allow-list back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("sitewide_token_support", TRUE)
    ->set("token_allowed_attributes", ["employeenumber", "campusbuilding"])
    ->save();
' >/dev/null 2>&1
echo "setup: sitewide_token_support=TRUE, token_allowed_attributes=[employeenumber, campusbuilding]"
