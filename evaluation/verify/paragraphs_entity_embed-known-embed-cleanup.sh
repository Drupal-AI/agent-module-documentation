#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'PEE Known Embed' embedded_paragraphs entity and its paragraph.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("embedded_paragraphs");
  foreach ($storage->loadByProperties(["label" => "PEE Known Embed"]) as $e) {
    foreach ($e->getParagraph() as $p) { $p->delete(); }
    $e->delete();
  }
' >/dev/null 2>&1
echo "cleanup: 'PEE Known Embed' embedded_paragraphs removed"
