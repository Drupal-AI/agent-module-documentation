#!/usr/bin/env bash
# Restore securitytxt.settings to install defaults after the known-policy introspection case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("securitytxt.settings")
    ->set("enabled", FALSE)
    ->set("enabled_signature", FALSE)
    ->set("contact_email", "")
    ->set("contact_phone", "")
    ->set("contact_page_url", "")
    ->set("encryption_key_url", "")
    ->set("policy_url", "")
    ->set("acknowledgments_url", "")
    ->set("signature_text", "")
    ->clear("expiry_date")
    ->clear("hiring_url")
    ->clear("preferred_languages")
    ->clear("canonical_urls")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: securitytxt.settings restored to install defaults"
