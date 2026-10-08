#!/usr/bin/env bash
# Introspection SETUP: seed a known email attribute mapping so the agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("miniorange_saml.settings")
    ->set("miniorange_saml_email_attribute", "urn:oid:0.9.2342.19200300.100.1.3-known")->save();
' >/dev/null 2>&1
echo "setup: miniorange_saml_email_attribute = urn:oid:0.9.2342.19200300.100.1.3-known"
