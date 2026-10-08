#!/usr/bin/env bash
# Execution CLEANUP: delete the "Product Glossary" entity/entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  foreach ($s->loadByProperties(["label" => "Product Glossary"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'Product Glossary' removed"
