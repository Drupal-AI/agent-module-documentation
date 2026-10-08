#!/usr/bin/env bash
# Introspection SETUP: create a contact form cse_feedback.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  if (!ContactForm::load("cse_feedback")) {
    ContactForm::create(["id" => "cse_feedback", "label" => "CSE Feedback", "recipients" => ["admin@example.com"], "message" => "Thanks", "redirect" => ""])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: contact form cse_feedback created"
