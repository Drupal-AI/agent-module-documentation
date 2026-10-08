#!/usr/bin/env bash
# Introspection SETUP: create a custom token tc_greeting (type 'custom') with known content.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\token_custom\Entity\TokenCustom;
  if ($e = TokenCustom::load("tc_greeting")) { $e->delete(); }
  TokenCustom::create([
    "machine_name" => "tc_greeting", "name" => "Site Greeting", "type" => "custom",
    "content" => ["value" => "Welcome to Example Co", "format" => "plain_text"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: custom token tc_greeting (type custom) content 'Welcome to Example Co'"
