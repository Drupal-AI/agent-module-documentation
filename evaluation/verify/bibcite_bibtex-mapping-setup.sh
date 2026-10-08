#!/usr/bin/env bash
# Introspection SETUP: write the bibtex format's type/field mapping config (bibcite_entity.mapping.bibtex) with a known
# type mapping (article -> journal_article), so an agent can read which bibcite reference type a bibtex
# record type maps to. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.mapping.bibtex")
    ->set("format", "bibtex")->set("types", ["article" => "journal_article"])->save();
' >/dev/null 2>&1
echo "setup: bibcite_entity.mapping.bibtex types.article=journal_article"
