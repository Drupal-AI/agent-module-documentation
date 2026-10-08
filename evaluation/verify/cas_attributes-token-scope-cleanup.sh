#!/usr/bin/env bash
# Introspection CLEANUP: turn sitewide token support back off and clear the allow-list.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("sitewide_token_support", FALSE)
    ->set("token_allowed_attributes", [])
    ->save();
' >/dev/null 2>&1
echo "cleanup: sitewide_token_support=FALSE, token_allowed_attributes=[]"
