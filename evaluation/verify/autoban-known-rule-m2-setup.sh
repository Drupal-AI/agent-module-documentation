#!/usr/bin/env bash
# Introspection SETUP: create a known autoban rule ab_test_m2 that scans the 'access denied'
# log type over a '1 day' window (threshold 4, provider ban, anonymous). Lets an agent read
# the log type + window off the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_m2")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_m2", "type" => "access denied", "message" => "node",
    "referer" => "", "threshold" => 4, "window" => "1 day", "provider" => "ban",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: autoban rule ab_test_m2 (type 'access denied', window '1 day')"
