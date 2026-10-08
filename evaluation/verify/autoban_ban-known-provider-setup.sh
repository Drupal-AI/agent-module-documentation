#!/usr/bin/env bash
# Introspection SETUP (autoban_ban): ensure autoban_ban is enabled and create an autoban rule
# ab_test_banname whose provider is 'ban', so an agent can resolve that provider id to its
# human name via the live provider registry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en autoban_ban -y >/dev/null 2>&1 || true
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_banname")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_banname", "type" => "page not found", "message" => "xmlrpc",
    "referer" => "", "threshold" => 6, "window" => "1 hour", "provider" => "ban",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: rule ab_test_banname uses provider 'ban' (autoban_ban enabled)"
