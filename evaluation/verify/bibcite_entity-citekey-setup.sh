#!/usr/bin/env bash
# Introspection SETUP: set the global citation-key pattern in bibcite_entity.reference.settings to
# a known value so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.reference.settings")
    ->set("citekey", ["pattern" => "known_[bibcite_reference:id]"])->save();
' >/dev/null 2>&1
echo "setup: bibcite_entity.reference.settings citekey.pattern = known_[bibcite_reference:id]"
