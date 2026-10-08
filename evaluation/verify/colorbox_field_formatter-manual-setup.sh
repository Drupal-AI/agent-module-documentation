#!/usr/bin/env bash
# Introspection SETUP: create a string field field_cff_link on Article displayed with the
# Colorbox FF formatter set to a MANUAL link pointing at /cff-target-page, so an inspecting agent
# can read back the link target. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cff_link")) {
    FieldStorageConfig::create(["field_name"=>"field_cff_link","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cff_link")) {
    FieldConfig::create(["field_name"=>"field_cff_link","entity_type"=>"node","bundle"=>"article","label"=>"CFF Link"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_cff_link", [
    "type" => "colorbox_field_formatter",
    "settings" => ["style"=>"default","link_type"=>"manual","link"=>"/cff-target-page","width"=>"500","height"=>"500","iframe"=>0],
    "region" => "content", "weight" => 21,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_cff_link uses colorbox_field_formatter, manual link=/cff-target-page"
