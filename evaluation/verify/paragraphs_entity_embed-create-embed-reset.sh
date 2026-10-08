#!/usr/bin/env bash
# Execution RESET: remove any embedded_paragraphs entity labelled 'PEE Hard Embed' (and stray
# reset paragraphs), so verify FAILS until the agent creates one. Uses the existing bp_simple
# paragraph type (does NOT create/delete a paragraphs_type, which would trigger a menu rebuild).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("embedded_paragraphs");
  foreach ($storage->loadByProperties(["label" => "PEE Hard Embed"]) as $e) {
    foreach ($e->getParagraph() as $p) { $p->delete(); }
    $e->delete();
  }
' >/dev/null 2>&1
echo "reset: no embedded_paragraphs labelled 'PEE Hard Embed' (embed via bp_simple paragraph type)"
