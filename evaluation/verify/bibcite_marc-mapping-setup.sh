#!/usr/bin/env bash
# Introspection SETUP: write the marc format's type/field mapping config (bibcite_entity.mapping.marc) with a known
# type mapping (book -> book), so an agent can read which bibcite reference type a marc
# record type maps to. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.mapping.marc")
    ->set("format", "marc")->set("types", ["book" => "book"])->save();
' >/dev/null 2>&1
echo "setup: bibcite_entity.mapping.marc types.book=book"
