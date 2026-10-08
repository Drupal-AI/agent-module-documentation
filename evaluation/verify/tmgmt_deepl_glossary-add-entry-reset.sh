#!/usr/bin/env bash
# Execution RESET: ensure a deepl_glossary "Product Glossary" exists (en -> de) with NO entries,
# so verify FAILS until the agent adds the term pair product -> Produkt. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  foreach ($s->loadByProperties(["label" => "Product Glossary"]) as $g) { $g->delete(); }
  $s->create([
    "label" => "Product Glossary",
    "source_lang" => "en", "target_lang" => "de", "glossary_id" => "", "ready" => FALSE,
    "entries" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: 'Product Glossary' present with no entries"
