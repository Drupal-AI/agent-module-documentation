#!/usr/bin/env bash
# Introspection SETUP: create a Remote Media type "mr_known" (source media_remote) with the
# string source field field_mr_url, and configure its DEFAULT media view display to render that
# field with the DocumentCloud provider formatter, so an inspecting agent can read the provider
# back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!MediaType::load("mr_known")) {
    MediaType::create(["id" => "mr_known", "label" => "MR Known", "source" => "media_remote"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_mr_url")) {
    FieldStorageConfig::create([
      "field_name" => "field_mr_url", "entity_type" => "media", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("media", "mr_known", "field_mr_url")) {
    FieldConfig::create([
      "field_name" => "field_mr_url", "entity_type" => "media",
      "bundle" => "mr_known", "label" => "Remote URL", "required" => TRUE,
    ])->save();
  }
  $t = MediaType::load("mr_known");
  $t->set("source_configuration", ["source_field" => "field_mr_url"])->save();
  $d = EntityViewDisplay::load("media.mr_known.default") ?: EntityViewDisplay::create([
    "targetEntityType" => "media", "bundle" => "mr_known", "mode" => "default", "status" => TRUE,
  ]);
  $d->setComponent("field_mr_url", [
    "type" => "media_remote_documentcloud", "label" => "hidden", "weight" => 0, "region" => "content",
    "settings" => ["formatter_class" => "Drupal\\media_remote\\Plugin\\Field\\FieldFormatter\\MediaRemoteDocumentcloudFormatter"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mr_known (source media_remote, field_mr_url) renders via media_remote_documentcloud"
