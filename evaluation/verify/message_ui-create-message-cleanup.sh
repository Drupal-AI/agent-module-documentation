#!/usr/bin/env bash
# Execution CLEANUP: delete messages of message_ui_hard and the template. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  use Drupal\message\Entity\Message;
  $ids = \Drupal::entityQuery("message")->accessCheck(FALSE)->condition("template","message_ui_hard")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("message")->delete(Message::loadMultiple($ids)); }
  if ($t=MessageTemplate::load("message_ui_hard")){$t->delete();}
' >/dev/null 2>&1
echo "cleanup: message_ui_hard messages + template removed"
