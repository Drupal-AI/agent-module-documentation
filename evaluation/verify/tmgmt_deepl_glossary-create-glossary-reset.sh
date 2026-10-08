#!/usr/bin/env bash
# Execution RESET: ensure NO deepl_glossary labelled "Legal Terms FR" exists, so verify FAILS
# until the agent creates one translating EN -> FR. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  foreach ($s->loadByProperties(["label" => "Legal Terms FR"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
echo "reset: 'Legal Terms FR' glossary absent"
