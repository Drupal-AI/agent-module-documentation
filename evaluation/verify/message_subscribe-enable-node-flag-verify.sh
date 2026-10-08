#!/usr/bin/env bash
# Execution VERIFY (message_subscribe): PASS when the subscribe_node flag exists and is ENABLED, so
# users can subscribe to content and message_subscribe treats it as a subscription flag. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node");
  $ok = ($f && $f->status() === TRUE);
  print ($ok ? "PASS" : "FAIL") . " flag=" . ($f ? "present" : "missing") . " status=" . var_export($f ? $f->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
