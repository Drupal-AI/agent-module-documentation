#!/usr/bin/env bash
# Execution RESET: field_reg_ief exists on node.article with the DEFAULT widget (registration_type),
# so verify fails until the agent switches it to the IEF settings widget.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_reg_ief")) {
    FieldStorageConfig::create(["field_name"=>"field_reg_ief","entity_type"=>"node","type"=>"registration"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_reg_ief")) {
    FieldConfig::create(["field_name"=>"field_reg_ief","entity_type"=>"node","bundle"=>"article","label"=>"Registration (IEF)"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_reg_ief",["type"=>"registration_type","weight"=>60,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "reset: node.article field_reg_ief widget=registration_type (default)"
