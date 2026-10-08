#!/usr/bin/env bash
# Execution RESET: ensure Message template 'message_ui_hard' exists and DELETE any existing
# messages of it (so verify fails until the agent creates one). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  use Drupal\message\Entity\Message;
  if (!MessageTemplate::load("message_ui_hard")) {
    MessageTemplate::create(["template"=>"message_ui_hard","label"=>"Message UI Hard","text"=>[["value"=>"H","format"=>"basic_html"]]])->save();
  }
  $ids = \Drupal::entityQuery("message")->accessCheck(FALSE)->condition("template","message_ui_hard")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("message")->delete(Message::loadMultiple($ids)); }
' >/dev/null 2>&1
echo "reset: template message_ui_hard present, its messages cleared"
