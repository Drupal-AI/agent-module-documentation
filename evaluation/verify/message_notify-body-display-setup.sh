#!/usr/bin/env bash
# Introspection SETUP: create a message template (bundle) mn_alert; message_notify auto-creates
# its mail_subject/mail_body entity view displays. Agent must inspect the mail_body display.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  if (!MessageTemplate::load("mn_alert")) {
    MessageTemplate::create([
      "template" => "mn_alert", "label" => "MN Alert",
      "text" => [["value" => "Alert subject", "format" => "plain_text"], ["value" => "Alert body", "format" => "plain_text"]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: message template mn_alert created; mail_subject/mail_body displays auto-generated"
