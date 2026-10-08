#!/usr/bin/env bash
# Introspection SETUP: create Message template 'message_ui_view'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  if (!MessageTemplate::load("message_ui_view")) {
    MessageTemplate::create(["template"=>"message_ui_view","label"=>"Message UI View","text"=>[["value"=>"V","format"=>"basic_html"]]])->save();
  }
' >/dev/null 2>&1
echo "setup: message_template message_ui_view created"
