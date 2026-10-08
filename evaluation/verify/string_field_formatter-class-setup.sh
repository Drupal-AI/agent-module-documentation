#!/usr/bin/env bash
# Introspection SETUP: string field field_sff_cls on Article formatted with plain_string_formatter,
# wrap_tag=span, wrap_class="highlight badge", so an agent can read back the classes.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sff_cls")) {
    FieldStorageConfig::create(["field_name" => "field_sff_cls", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sff_cls")) {
    FieldConfig::create(["field_name" => "field_sff_cls", "entity_type" => "node", "bundle" => "article", "label" => "SFF Cls"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sff_cls", ["type" => "plain_string_formatter", "weight" => 51, "region" => "content", "label" => "hidden", "settings" => ["wrap_tag" => "span", "wrap_class" => "highlight badge"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_sff_cls plain_string_formatter wrap_tag=span wrap_class='highlight badge'"
