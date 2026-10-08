#!/usr/bin/env bash
# Execution RESET: ensure entity_reference field field_ieftvm_h1 exists on Article with a plain
# autocomplete widget on the default form display (NOT the table view mode widget), so verify FAILS
# until the agent switches it to inline_entity_form_complex_table_view_mode.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ieftvm_h1")) {
    FieldStorageConfig::create(["field_name"=>"field_ieftvm_h1","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ieftvm_h1")) {
    FieldConfig::create(["field_name"=>"field_ieftvm_h1","entity_type"=>"node","bundle"=>"article","label"=>"IEF H1 Ref"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ieftvm_h1", ["type"=>"entity_reference_autocomplete","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ieftvm_h1 present with entity_reference_autocomplete widget"
