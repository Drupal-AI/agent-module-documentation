#!/usr/bin/env bash
# Execution CLEANUP: delete the 'PEE Hard Embed' embedded_paragraphs entity and its paragraph.
# Restores baseline. Does not touch paragraph types. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("embedded_paragraphs");
  foreach ($storage->loadByProperties(["label" => "PEE Hard Embed"]) as $e) {
    foreach ($e->getParagraph() as $p) { $p->delete(); }
    $e->delete();
  }
' >/dev/null 2>&1
echo "cleanup: 'PEE Hard Embed' embedded_paragraphs removed"
