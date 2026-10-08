#!/usr/bin/env bash
# Introspection SETUP: create entity_reference field field_ff_inline (node->article) on
# Article and configure its DEFAULT view display to use the
# "field_formatter_with_inline_settings" formatter showing the referenced 'body' field with
# the text_default formatter, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ff_inline")) {
    FieldStorageConfig::create(["field_name"=>"field_ff_inline","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ff_inline")) {
    FieldConfig::create(["field_name"=>"field_ff_inline","entity_type"=>"node","bundle"=>"article","label"=>"FF Inline","settings"=>["handler"=>"default:node","handler_settings"=>["target_bundles"=>["article"=>"article"]]]])->save();
  }
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ff_inline", ["type"=>"field_formatter_with_inline_settings","label"=>"hidden","region"=>"content","weight"=>61,"settings"=>["field_name"=>"body","type"=>"text_default","settings"=>[],"label"=>"above","link_to_entity"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ff_inline uses field_formatter_with_inline_settings (field_name=body, type=text_default)"
