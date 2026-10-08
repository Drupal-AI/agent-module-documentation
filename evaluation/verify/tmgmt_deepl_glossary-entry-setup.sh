#!/usr/bin/env bash
# Introspection SETUP: create a deepl_glossary "Eval Terms Glossary" with a known term pair
# (subject "invoice" -> definition "Rechnung") so an inspecting agent can read the German
# translation stored for the term "invoice". Idempotent (keyed on label). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  if (!$s->loadByProperties(["label" => "Eval Terms Glossary"])) {
    $s->create([
      "label" => "Eval Terms Glossary",
      "source_lang" => "en", "target_lang" => "de", "glossary_id" => "", "ready" => FALSE,
      "entries" => [["subject" => "invoice", "definition" => "Rechnung"]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: deepl_glossary 'Eval Terms Glossary' with entry invoice -> Rechnung"
