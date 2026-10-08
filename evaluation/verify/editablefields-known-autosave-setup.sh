#!/usr/bin/env bash
# Introspection SETUP: create a text field field_ef_auto on Article set to editablefields_formatter
# with autosave configured (submits via ajax on 'blur'), so the agent must inspect the live view
# display to report the autosave trigger field/event. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ef_auto")) {
    FieldStorageConfig::create(["field_name"=>"field_ef_auto","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ef_auto")) {
    FieldConfig::create(["field_name"=>"field_ef_auto","entity_type"=>"node","bundle"=>"article","label"=>"Autosave Note"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ef_auto", [
    "type" => "editablefields_formatter", "label" => "hidden", "weight" => 81, "region" => "content",
    "settings" => ["form_mode" => "default", "behaviour" => "inline", "fields_ajax_trigger" => "field_ef_auto", "fields_ajax_trigger_event" => "blur"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ef_auto editablefields_formatter autosave on blur"
