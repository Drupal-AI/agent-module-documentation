#!/usr/bin/env bash
# Introspection SETUP: write a known webform_spam_words.settings config (spam_words
# includes 'casino'; spam_field_name = 'subject'; spam_text_message = 'Blocked: spam
# detected') so an inspecting agent can read back which field is currently checked.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("webform_spam_words.settings");
  $config->set("spam_words", ["SEO", "casino"]);
  $config->set("spam_text_message", "Blocked: spam detected");
  $config->set("spam_field_name", "subject");
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform_spam_words.settings spam_field_name=subject, spam_words includes casino"
