#!/usr/bin/env bash
# Execution CLEANUP: delete template mn_send, its messages and displays. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  foreach (\Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "mn_send"]) as $m) { $m->delete(); }
  foreach (["mail_subject","mail_body","default"] as $vm) {
    if ($d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("message.mn_send.$vm")) { $d->delete(); }
  }
  if ($t = MessageTemplate::load("mn_send")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: message template mn_send removed"
