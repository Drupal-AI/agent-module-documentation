#!/usr/bin/env bash
# Execution VERIFY: PASS when the {history} table holds a row for uid 1 and the node titled
# 'History Task Node' with a non-zero timestamp. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "History Task Node")->execute();
  if (!$ids) { print "FAIL node-missing\n"; return; }
  $nid = (int) reset($ids);
  $ts = \Drupal::database()->select("history", "h")
    ->fields("h", ["timestamp"])
    ->condition("uid", 1)
    ->condition("nid", $nid)
    ->execute()->fetchField();
  $ok = ($ts !== FALSE && (int) $ts > 0);
  print ($ok ? "PASS" : "FAIL") . " nid=" . $nid . " uid=1 timestamp=" . var_export($ts, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
