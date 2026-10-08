#!/usr/bin/env bash
# Introspection SETUP (autoban_ban): ensure autoban_ban is enabled and create an autoban rule
# ab_test_ban2 that uses the core Ban provider ('ban'), scans the 'access denied' log type with
# a distinctive threshold (15), so an agent can read the log type + threshold off the live rule.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en autoban_ban -y >/dev/null 2>&1 || true
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_ban2")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_ban2", "type" => "access denied", "message" => "node/*",
    "referer" => "", "threshold" => 15, "window" => "2 hours", "provider" => "ban",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: rule ab_test_ban2 provider 'ban', type 'access denied', threshold 15"
