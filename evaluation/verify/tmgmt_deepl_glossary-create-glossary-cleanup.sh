#!/usr/bin/env bash
# Execution CLEANUP: delete the "Legal Terms FR" deepl_glossary entity/entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  foreach ($s->loadByProperties(["label" => "Legal Terms FR"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
echo "cleanup: 'Legal Terms FR' removed"
