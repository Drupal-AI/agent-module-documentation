#!/usr/bin/env bash
# Introspection SETUP: record a Privacy policy content link in the base gdpr module's config
# (gdpr.content_mapping) for the default language, so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $lang = \Drupal::languageManager()->getDefaultLanguage()->getId();
  \Drupal::configFactory()->getEditable("gdpr.content_mapping")
    ->set("links", [$lang => [
      "privacy_policy" => "internal:/privacy-policy",
      "terms_of_use" => "", "about_us" => "", "impressum" => "",
    ]])->save();
' >/dev/null 2>&1
echo "setup: gdpr.content_mapping links.<default>.privacy_policy = internal:/privacy-policy"
