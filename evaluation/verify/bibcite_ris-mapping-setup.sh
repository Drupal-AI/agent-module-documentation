#!/usr/bin/env bash
# Introspection SETUP: write the ris format's type/field mapping config (bibcite_entity.mapping.ris) with a known
# type mapping (BOOK -> book), so an agent can read which bibcite reference type a ris
# record type maps to. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.mapping.ris")
    ->set("format", "ris")->set("types", ["BOOK" => "book"])->save();
' >/dev/null 2>&1
echo "setup: bibcite_entity.mapping.ris types.BOOK=book"
