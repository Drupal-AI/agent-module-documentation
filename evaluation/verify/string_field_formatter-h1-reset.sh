#!/usr/bin/env bash
# Execution RESET: string field field_sff_head on Article formatted with plain_string_formatter
# but wrap_tag=_none (no wrapper), so verify (which needs wrap_tag=h1) FAILS until set. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sff_head")) {
    FieldStorageConfig::create(["field_name" => "field_sff_head", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sff_head")) {
    FieldConfig::create(["field_name" => "field_sff_head", "entity_type" => "node", "bundle" => "article", "label" => "SFF Head"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sff_head", ["type" => "plain_string_formatter", "weight" => 53, "region" => "content", "label" => "hidden", "settings" => ["wrap_tag" => "_none", "wrap_class" => ""]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_sff_head plain_string_formatter wrap_tag=_none"
