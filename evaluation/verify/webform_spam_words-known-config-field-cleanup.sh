#!/usr/bin/env bash
# Introspection CLEANUP: restore webform_spam_words.settings to its shipped config/install
# defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("webform_spam_words.settings");
  $config->set("spam_words", ["SEO", "Digital Marketing", "Click Here", "unsubscribe", "FREE", "trial"]);
  $config->set("spam_text_message", "Unable to submit form. Please contact the site administrator, if the problem persists.");
  $config->set("spam_field_name", "message");
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform_spam_words.settings restored to shipped defaults"
