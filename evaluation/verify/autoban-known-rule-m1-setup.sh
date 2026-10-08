#!/usr/bin/env bash
# Introspection SETUP: create a known autoban rule (config entity) so an agent can read a
# field back off the live config. Rule ab_test_m1 scans 'page not found' for 'wp-login',
# threshold 7, window '1 hour', provider 'ban', anonymous users. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_m1")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_m1", "type" => "page not found", "message" => "wp-login",
    "referer" => "", "threshold" => 7, "window" => "1 hour", "provider" => "ban",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: autoban rule ab_test_m1 (threshold 7, provider ban, type 'page not found')"
