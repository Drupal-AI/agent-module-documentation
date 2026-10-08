#!/usr/bin/env bash
# Introspection CLEANUP: delete message template mn_alert and its view displays. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  foreach (["mail_subject","mail_body","default"] as $vm) {
    if ($d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("message.mn_alert.$vm")) { $d->delete(); }
  }
  if ($t = MessageTemplate::load("mn_alert")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: message template mn_alert removed"
