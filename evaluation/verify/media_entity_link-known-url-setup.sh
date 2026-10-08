#!/usr/bin/env bash
# Introspection SETUP: create a Link media entity with a known URL so an agent can read it back.
# Idempotent (removes any prior copy first by name). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($st->loadByProperties(["bundle" => "link", "name" => "Known MEL Resource"]) as $m) { $m->delete(); }
  $st->create([
    "bundle" => "link", "name" => "Known MEL Resource",
    "field_media_entity_link" => ["uri" => "https://example.com/known-mel-resource", "title" => ""],
  ])->save();
' >/dev/null 2>&1
echo "setup: Link media 'Known MEL Resource' -> https://example.com/known-mel-resource"
