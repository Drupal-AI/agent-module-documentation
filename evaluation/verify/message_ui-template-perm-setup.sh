#!/usr/bin/env bash
# Introspection SETUP: create Message template 'message_ui_eval' so message_ui generates its
# per-template permissions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  if (!MessageTemplate::load("message_ui_eval")) {
    MessageTemplate::create(["template"=>"message_ui_eval","label"=>"Message UI Eval","text"=>[["value"=>"Eval","format"=>"basic_html"]]])->save();
  }
' >/dev/null 2>&1
echo "setup: message_template message_ui_eval created"
