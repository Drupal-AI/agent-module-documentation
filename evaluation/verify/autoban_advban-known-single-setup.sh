#!/usr/bin/env bash
# Introspection SETUP (autoban_advban): create an autoban rule ab_test_advban_single whose
# provider is the Advanced Ban SINGLE provider ('advban') scanning 'page not found' with a
# distinctive threshold (10), so an agent can read the provider id + threshold off the live
# rule config. (autoban_advban need not be enabled — provider is a stored config string.)
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("autoban");
  if ($e = $s->load("ab_test_advban_single")) { $e->delete(); }
  $s->create([
    "id" => "ab_test_advban_single", "type" => "page not found", "message" => "wp-login",
    "referer" => "", "threshold" => 10, "window" => "2 hours", "provider" => "advban",
    "user_type" => 1, "rule_type" => 1,
  ])->save();
' >/dev/null 2>&1
echo "setup: rule ab_test_advban_single uses provider 'advban' (single), threshold 10"
