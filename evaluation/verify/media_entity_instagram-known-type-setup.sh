#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN media type that uses the Instagram source so an
# inspecting agent can read back which source plugin it uses. The media type `ig_known`
# has source `oembed:instagram` and a string source field `field_media_oembed_instagram`.
# It does not ship by default, so it is safe to create/delete. Idempotent (recreated each
# run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("ig_known")) {
    $type = MediaType::create([
      "id" => "ig_known",
      "label" => "IG Known",
      "source" => "oembed:instagram",
      "source_configuration" => ["source_field" => ""],
    ]);
    $type->save();
    $field = $type->getSource()->createSourceField($type);
    $field->getFieldStorageDefinition()->save();
    $field->save();
    $type->set("source_configuration", ["source_field" => $field->getName()])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type ig_known (source oembed:instagram) created"
