#!/usr/bin/env bash
# Execution VERIFY: PASS when there are NO key_value rows in any collection starting with
# 'domain_path_pathauto_state.dpp_task.' (i.e. the domain's pathauto state has been purged). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $n = $db->select("key_value","kv")
    ->condition("collection", $db->escapeLike("domain_path_pathauto_state.dpp_task.") . "%", "LIKE")
    ->countQuery()->execute()->fetchField();
  $ok = ((int) $n === 0);
  print ($ok ? "PASS" : "FAIL") . " remaining_rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
