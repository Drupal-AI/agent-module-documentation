#!/usr/bin/env bash
# Introspection SETUP: create a paragraphs field on Article and set its VIEW display to the
# Paragraphs table formatter with mode=bootstrapTable, so an agent can read the mode back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pt_evm")) { ParagraphsType::create(["id"=>"pt_evm","label"=>"PT Eval Medium"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pt_evm")) {
    FieldStorageConfig::create(["field_name"=>"field_pt_evm","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pt_evm")) {
    FieldConfig::create(["field_name"=>"field_pt_evm","entity_type"=>"node","bundle"=>"article","label"=>"PT Eval Medium","settings"=>["handler"=>"default:paragraph","handler_settings"=>["target_bundles"=>["pt_evm"=>"pt_evm"]]]])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_pt_evm", ["type"=>"paragraphs_table_formatter","region"=>"content","weight"=>50,"settings"=>["mode"=>"bootstrapTable","vertical"=>FALSE,"view_mode"=>"default"]])->save();
' >/dev/null 2>&1
echo "setup: node.article field_pt_evm view display uses paragraphs_table_formatter mode=bootstrapTable"
