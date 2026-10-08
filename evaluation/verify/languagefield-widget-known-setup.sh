#!/usr/bin/env bash
# Introspection SETUP: create a language_field field field_lf_known on Article and set its
# default-form-display widget to languagefield_autocomplete, so an inspecting agent can read
# back which widget is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_lf_known", "entity_type" => "node", "type" => "language_field",
      "settings" => ["maxlength" => 12, "language_range" => [11 => 11], "allowed_values_function" => "languagefield_allowed_values"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_lf_known")) {
    FieldConfig::create([
      "field_name" => "field_lf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Language",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lf_known", ["type" => "languagefield_autocomplete", "weight" => 50, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_lf_known (language_field) uses widget languagefield_autocomplete"
