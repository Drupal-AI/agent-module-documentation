#!/usr/bin/env bash
# Introspection SETUP: create a string field field_cff_known on Article and display it with the
# Colorbox FF formatter using a distinctive popup width (777), so an inspecting agent can read it
# back from the view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cff_known")) {
    FieldStorageConfig::create(["field_name"=>"field_cff_known","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cff_known")) {
    FieldConfig::create(["field_name"=>"field_cff_known","entity_type"=>"node","bundle"=>"article","label"=>"CFF Known"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_cff_known", [
    "type" => "colorbox_field_formatter",
    "settings" => ["style"=>"default","link_type"=>"content","width"=>"777","height"=>"500","iframe"=>0],
    "region" => "content", "weight" => 20,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_cff_known uses colorbox_field_formatter with width=777"
