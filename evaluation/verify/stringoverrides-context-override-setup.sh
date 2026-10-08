#!/usr/bin/env bash
# Introspection SETUP: write an override that uses a non-empty context (the ambiguous month
# "May" -> "Mai" in context "Long month name"), so an agent must read the context structure.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("stringoverrides.string_override.en");
  $c->set("contexts", [
    ["context" => "", "translations" => [["source" => "Home", "translation" => "Welcome"]]],
    ["context" => "Long month name", "translations" => [["source" => "May", "translation" => "Mai"]]],
  ])->save();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
' >/dev/null 2>&1
echo "setup: 'May' overridden to 'Mai' under context 'Long month name'"
