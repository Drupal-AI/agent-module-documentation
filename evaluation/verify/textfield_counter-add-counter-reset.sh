#!/usr/bin/env bash
# Execution RESET: ensure a text_long field field_tfc_task exists on Article using the CORE
# text_textarea widget (NOT the counter widget), so verify FAILS until the agent switches it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tfc_task")) {
    FieldStorageConfig::create(["field_name"=>"field_tfc_task","entity_type"=>"node","type"=>"text_long"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tfc_task")) {
    FieldConfig::create(["field_name"=>"field_tfc_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Body"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tfc_task", ["type"=>"text_textarea","weight"=>62,"region"=>"content","settings"=>["rows"=>5]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tfc_task uses core text_textarea (no counter)"
