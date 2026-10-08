#!/usr/bin/env bash
# Reset securitytxt.settings to a clean, disabled baseline so each execution run starts empty.
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
echo "reset: securitytxt.settings cleared to disabled baseline"
