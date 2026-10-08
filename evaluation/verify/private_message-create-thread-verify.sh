#!/usr/bin/env bash
# Execution VERIFY for "create a private message thread between the two pm_eval users".
# PASS when a private_message_thread exists whose members are exactly the two pm_eval users and
# which contains at least one message whose body includes the marker "PM_EVAL". Prints PASS/FAIL.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mails = ["pm_eval_alice@example.com", "pm_eval_bob@example.com"];
  $uids = [];
  foreach ($mails as $m) {
    $e = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => $m]);
    if ($e) { $uids[] = reset($e)->id(); }
  }
  sort($uids);
  $ok = FALSE;
  if (count($uids) === 2) {
    $tids = \Drupal::entityQuery("private_message_thread")->accessCheck(FALSE)->execute();
    foreach ($tids as $tid) {
      $t = \Drupal::entityTypeManager()->getStorage("private_message_thread")->load($tid);
      $mem = $t->getMembersId(); sort($mem);
      if ($mem === $uids) {
        foreach ($t->getMessages(TRUE) as $msg) {
          if (strpos((string) $msg->getMessage(), "PM_EVAL") !== FALSE) { $ok = TRUE; }
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " members=" . implode(",", $uids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
