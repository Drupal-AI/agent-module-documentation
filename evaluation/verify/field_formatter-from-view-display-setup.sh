#!/usr/bin/env bash
# Introspection SETUP: create entity_reference field field_ff_ref (node->article) on Article
# and configure its DEFAULT view-display component to use field_formatter's
# "field_formatter_from_view_display" formatter (view_mode teaser, field_name body), so an
# agent can read back the formatter and its settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ff_ref")) {
    FieldStorageConfig::create(["field_name"=>"field_ff_ref","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ff_ref")) {
    FieldConfig::create(["field_name"=>"field_ff_ref","entity_type"=>"node","bundle"=>"article","label"=>"FF Reference","settings"=>["handler"=>"default:node","handler_settings"=>["target_bundles"=>["article"=>"article"]]]])->save();
  }
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ff_ref", ["type"=>"field_formatter_from_view_display","label"=>"hidden","region"=>"content","weight"=>60,"settings"=>["view_mode"=>"teaser","field_name"=>"body","link_to_entity"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ff_ref uses field_formatter_from_view_display (view_mode=teaser, field_name=body)"
