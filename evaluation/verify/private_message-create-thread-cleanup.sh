#!/usr/bin/env bash
# Execution CLEANUP: remove the pm_eval thread + messages, delete the two pm_eval users, and
# restore enable_notifications to its shipped default (true). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $mails = ["pm_eval_alice@example.com", "pm_eval_bob@example.com"];
  $uids = [];
  foreach ($mails as $m) {
    $e = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => $m]);
    if ($e) { $uids[] = reset($e)->id(); }
  }
  sort($uids);
  $tids = \Drupal::entityQuery("private_message_thread")->accessCheck(FALSE)->execute();
  foreach ($tids as $tid) {
    $t = \Drupal::entityTypeManager()->getStorage("private_message_thread")->load($tid);
    $mem = $t->getMembersId(); sort($mem);
    if ($mem && $uids && $mem === $uids) {
      foreach ($t->getMessages(TRUE) as $msg) { $msg->delete(); }
      $t->delete();
    }
  }
  foreach ($uids as $uid) { if ($u = \Drupal\user\Entity\User::load($uid)) { $u->delete(); } }
  \Drupal::configFactory()->getEditable("private_message.settings")->set("enable_notifications", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: pm_eval users/thread removed, enable_notifications restored to true"
