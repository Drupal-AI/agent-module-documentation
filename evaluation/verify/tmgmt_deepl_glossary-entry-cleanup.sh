#!/usr/bin/env bash
# Introspection CLEANUP: delete the "Eval Terms Glossary" entity/entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  foreach ($s->loadByProperties(["label" => "Eval Terms Glossary"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'Eval Terms Glossary' removed"
