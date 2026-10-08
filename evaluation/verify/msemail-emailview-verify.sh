#!/usr/bin/env bash
# Execution VERIFY (message_subscribe_email): PASS when subscribe_node's message_subscribe_ui
# view_name is the email-aware view 'subscribe_node_email:default'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $v = $f ? $f->getThirdPartySetting("message_subscribe_ui", "view_name") : NULL;
  $ok = ($v === "subscribe_node_email:default");
  print ($ok ? "PASS" : "FAIL") . " view_name=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
