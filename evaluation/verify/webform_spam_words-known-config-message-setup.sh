#!/usr/bin/env bash
# Introspection SETUP: write a known webform_spam_words.settings config with a distinct
# error message and a multi-field spam_field_name, so an inspecting agent can read back the
# configured error message. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("webform_spam_words.settings");
  $config->set("spam_words", ["lottery", "inheritance"]);
  $config->set("spam_text_message", "Your submission was rejected due to prohibited content.");
  $config->set("spam_field_name", "email,phone");
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform_spam_words.settings spam_text_message set to custom marker; spam_field_name=email,phone"
