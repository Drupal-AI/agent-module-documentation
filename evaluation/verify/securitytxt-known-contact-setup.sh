#!/usr/bin/env bash
# Introspection setup: write a known securitytxt.settings contact + expiry so the agent
# can read it back off the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("securitytxt.settings")
    ->set("enabled", TRUE)
    ->set("contact_email", "security@known-example.com")
    ->set("expiry_date", 1893456000)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: contact_email=security@known-example.com expiry_date=1893456000 (2030-01-01)"
