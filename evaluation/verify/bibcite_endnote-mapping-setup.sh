#!/usr/bin/env bash
# Introspection SETUP: write the endnote7 format's type/field mapping config (bibcite_entity.mapping.endnote7) with a known
# type mapping (Book -> book), so an agent can read which bibcite reference type a endnote7
# record type maps to. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.mapping.endnote7")
    ->set("format", "endnote7")->set("types", ["Book" => "book"])->save();
' >/dev/null 2>&1
echo "setup: bibcite_entity.mapping.endnote7 types.Book=book"
