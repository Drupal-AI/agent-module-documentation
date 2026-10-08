#!/usr/bin/env bash
# Introspection SETUP: create message template mn_welcome with a known subject (first text
# partial) so an agent can read it back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  if ($t = MessageTemplate::load("mn_welcome")) { $t->delete(); }
  MessageTemplate::create([
    "template" => "mn_welcome", "label" => "MN Welcome",
    "text" => [["value" => "MN Welcome Subject XYZ", "format" => "plain_text"], ["value" => "Welcome body text", "format" => "plain_text"]],
  ])->save();
' >/dev/null 2>&1
echo "setup: message template mn_welcome created with subject 'MN Welcome Subject XYZ'"
