#!/usr/bin/env bash
# Introspection setup: enable securitytxt and set a known policy URL + preferred languages
# so the agent can report them off the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("securitytxt.settings")
    ->set("enabled", TRUE)
    ->set("contact_email", "psirt@known-example.com")
    ->set("policy_url", "https://known-example.com/security-policy")
    ->set("preferred_languages", "en, nl")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: policy_url=https://known-example.com/security-policy preferred_languages='en, nl' enabled=TRUE"
