#!/usr/bin/env bash
# Introspection SETUP: create a string field field_sff_known on Article and format it on the
# default view display with plain_string_formatter, wrap_tag=h2, wrap_class="field-title big".
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sff_known")) {
    FieldStorageConfig::create(["field_name" => "field_sff_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sff_known")) {
    FieldConfig::create(["field_name" => "field_sff_known", "entity_type" => "node", "bundle" => "article", "label" => "SFF Known"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sff_known", ["type" => "plain_string_formatter", "weight" => 50, "region" => "content", "label" => "hidden", "settings" => ["wrap_tag" => "h2", "wrap_class" => "field-title big"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_sff_known plain_string_formatter wrap_tag=h2 wrap_class='field-title big'"
