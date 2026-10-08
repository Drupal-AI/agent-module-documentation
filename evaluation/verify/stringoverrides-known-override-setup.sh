#!/usr/bin/env bash
# Introspection SETUP: write a known English string override (Log in -> Sign in) into
# stringoverrides config so an inspecting agent can read back the replacement. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("stringoverrides.string_override.en");
  $c->set("contexts", [[
    "context" => "",
    "translations" => [
      ["source" => "Log in", "translation" => "Sign in"],
    ],
  ]])->save();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
' >/dev/null 2>&1
echo "setup: stringoverrides.string_override.en overrides 'Log in' -> 'Sign in'"
