#!/usr/bin/env bash
# Introspection SETUP: create a link field field_lft_known on Article using the core
# link_default widget, and enable link_field_tweak custom URI help text on that widget with a
# known string, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lft_known")) {
    FieldStorageConfig::create(["field_name" => "field_lft_known", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_lft_known")) {
    FieldConfig::create(["field_name" => "field_lft_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Link"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lft_known", [
    "type" => "link_default", "weight" => 60, "region" => "content",
    "third_party_settings" => ["link_field_tweak" => [
      "uri_part_custom_help" => TRUE,
      "uri_part_custom_help_text" => "Known campaign URL help",
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_lft_known link_default widget has uri_part_custom_help_text='Known campaign URL help'"
