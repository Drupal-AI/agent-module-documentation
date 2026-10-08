#!/usr/bin/env bash
# Introspection SETUP: set the SP entity_id in saml_sp.settings to a known value so the agent can
# inspect the live config and report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp.settings")->set("entity_id", "urn:smlsp-eval:sp")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: saml_sp.settings entity_id=urn:smlsp-eval:sp"
