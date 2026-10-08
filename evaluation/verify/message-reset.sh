#!/usr/bin/env bash
# HARD execution reset: clear the message state the build tasks create, so each hard case
# starts from a missing (failing) baseline. Deletes the eval message templates and any
# message content entities that belong to those template bundles. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = ["eval_signup", "eval_comment"];
  $msg = \Drupal::entityTypeManager()->getStorage("message");
  foreach ($ids as $id) {
    foreach ($msg->loadByProperties(["template" => $id]) as $m) { $m->delete(); }
  }
  $tpl = \Drupal::entityTypeManager()->getStorage("message_template");
  foreach ($ids as $id) {
    if ($t = $tpl->load($id)) { $t->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: message templates eval_signup/eval_comment + their messages removed"
