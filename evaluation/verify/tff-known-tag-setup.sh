#!/usr/bin/env bash
# Introspection SETUP: create string field field_tff_known on Article displayed with the
# text_field_formatter (wrap_tag h2), so an agent can read the wrapper tag back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tff_known")) {
    FieldStorageConfig::create(["field_name" => "field_tff_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tff_known")) {
    FieldConfig::create(["field_name" => "field_tff_known", "entity_type" => "node", "bundle" => "article", "label" => "TFF Known"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_tff_known", [
    "type" => "text_field_formatter", "label" => "hidden", "weight" => 50, "region" => "content",
    "settings" => ["wrap_tag" => "h2", "wrap_class" => "highlight", "wrap_attributes" => "", "override_link_label" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tff_known uses text_field_formatter wrap_tag=h2"
