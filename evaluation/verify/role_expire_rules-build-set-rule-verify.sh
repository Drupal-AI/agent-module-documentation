#!/usr/bin/env bash
# Execution VERIFY: PASS when rules.reaction.rer_task exists and its expression contains an action
# with action_id role_expire_set_expire_time. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("rules.reaction.rer_task")->get("expression");
  $ok = is_array($e) && strpos(json_encode($e), "role_expire_set_expire_time") !== FALSE;
  print (($ok) ? "PASS" : "FAIL") . " has_rule=" . (is_array($e) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
