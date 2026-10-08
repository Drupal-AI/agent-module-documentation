#!/usr/bin/env bash
# Execution RESET: ensure message template mn_task and its view displays do NOT exist, so
# verify FAILS until the agent creates the notification bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  foreach (["mail_subject","mail_body","default"] as $vm) {
    if ($d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("message.mn_task.$vm")) { $d->delete(); }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "mn_task"]) as $m) { $m->delete(); }
  if ($t = MessageTemplate::load("mn_task")) { $t->delete(); }
' >/dev/null 2>&1
echo "reset: message template mn_task removed (absent)"
