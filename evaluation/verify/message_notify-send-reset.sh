#!/usr/bin/env bash
# Execution RESET: ensure template mn_send exists (so the agent can send it) but NO saved
# Message of that template exists, so verify FAILS until the agent sends a notification (which
# by default saves the message). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  if (!MessageTemplate::load("mn_send")) {
    MessageTemplate::create([
      "template" => "mn_send", "label" => "MN Send",
      "text" => [["value" => "Send subject", "format" => "plain_text"], ["value" => "Send body", "format" => "plain_text"]],
    ])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "mn_send"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "reset: template mn_send present, no saved messages of it"
