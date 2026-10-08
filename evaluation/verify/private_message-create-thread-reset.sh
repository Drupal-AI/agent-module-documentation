#!/usr/bin/env bash
# Execution RESET for "create a private message thread between two users".
# Ensures the two namespaced users exist (pm_eval_alice@example.com / pm_eval_bob@example.com),
# disables new-message email notifications (isolates the test from the mail/render path), and
# deletes any existing thread whose members are exactly those two users (plus its messages), so
# verify FAILS on this empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $mails = ["pm_eval_alice@example.com", "pm_eval_bob@example.com"];
  \Drupal::configFactory()->getEditable("private_message.settings")->set("enable_notifications", FALSE)->save();
  $uids = [];
  foreach ($mails as $m) {
    $e = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => $m]);
    if ($e) { $uids[] = reset($e)->id(); }
    else {
      $u = \Drupal\user\Entity\User::create(["name" => $m, "mail" => $m, "status" => 1]);
      $u->save();
      $uids[] = $u->id();
    }
  }
  sort($uids);
  $tids = \Drupal::entityQuery("private_message_thread")->accessCheck(FALSE)->execute();
  foreach ($tids as $tid) {
    $t = \Drupal::entityTypeManager()->getStorage("private_message_thread")->load($tid);
    $mem = $t->getMembersId(); sort($mem);
    if ($mem === $uids) {
      foreach ($t->getMessages(TRUE) as $msg) { $msg->delete(); }
      $t->delete();
    }
  }
' >/dev/null 2>&1
echo "reset: pm_eval users present, notifications off, no thread between them"
