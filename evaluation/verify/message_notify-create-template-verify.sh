#!/usr/bin/env bash
# Execution VERIFY: PASS when message template mn_task exists AND message_notify's mail_body
# view display for it exists with partial_1 in the content region. Pure reads. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("message.template.mn_task")->get("template");
  $body = \Drupal::config("core.entity_view_display.message.mn_task.mail_body")->get("content");
  $has_body = is_array($body) && isset($body["partial_1"]);
  $ok = ($t === "mn_task" && $has_body);
  print (($ok) ? "PASS" : "FAIL") . " template=" . var_export($t, TRUE) . " mail_body_partial1=" . var_export($has_body, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
