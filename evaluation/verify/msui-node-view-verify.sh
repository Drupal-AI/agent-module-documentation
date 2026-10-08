#!/usr/bin/env bash
# Execution VERIFY (message_subscribe_ui): PASS when the subscribe_node flag's message_subscribe_ui
# view_name third-party setting is exactly 'subscribe_node:default'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $v = $f ? $f->getThirdPartySetting("message_subscribe_ui", "view_name") : NULL;
  $ok = ($v === "subscribe_node:default");
  print ($ok ? "PASS" : "FAIL") . " view_name=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
