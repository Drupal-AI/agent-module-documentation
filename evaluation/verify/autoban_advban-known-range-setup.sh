#!/usr/bin/env bash
# Introspection SETUP (autoban_advban): create an autoban rule ab_test_advban whose provider is
# the Advanced Ban range provider ('advban_range'), so an agent can read the provider id off the
# live rule config. (autoban_advban itself need not be enabled — the rule's provider is a stored
# config string.) Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_advban")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_advban", "type" => "access denied", "message" => "admin",
    "referer" => "", "threshold" => 3, "window" => "1 hour", "provider" => "advban_range",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: rule ab_test_advban uses provider 'advban_range'"
