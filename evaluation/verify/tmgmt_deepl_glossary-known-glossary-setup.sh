#!/usr/bin/env bash
# Introspection SETUP: create a deepl_glossary entity labelled "Eval Brand Glossary" translating
# EN -> DE so an inspecting agent can read its source/target languages. Idempotent (keyed on label). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  $existing = $s->loadByProperties(["label" => "Eval Brand Glossary"]);
  if (!$existing) {
    $s->create([
      "label" => "Eval Brand Glossary",
      "source_lang" => "en", "target_lang" => "de",
      "glossary_id" => "", "ready" => FALSE,
      "entries" => [["subject" => "dashboard", "definition" => "Übersicht"]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: deepl_glossary 'Eval Brand Glossary' (en -> de) created"
