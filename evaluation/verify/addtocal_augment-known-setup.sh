#!/usr/bin/env bash
# Introspection SETUP: create a datetime field field_atc_known on Article, and enable the
# addtocal Date Augmenter on its formatter (in node.article.default view display) with KNOWN
# settings (label, location, modal target, past_events on), so an inspecting agent can read them
# back from third_party_settings.date_augmenter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_known")) {
    FieldStorageConfig::create(["field_name" => "field_atc_known", "entity_type" => "node", "type" => "datetime", "settings" => ["datetime_type" => "datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_known")) {
    FieldConfig::create(["field_name" => "field_atc_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Event"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_known", [
    "type" => "datetime_default", "weight" => 60, "region" => "content",
    "third_party_settings" => ["date_augmenter" => ["instances" => [
      "status" => ["addtocal" => TRUE],
      "weights" => ["order" => ["addtocal" => ["weight" => 0]]],
      "settings" => ["addtocal" => [
        "label" => "Save the date",
        "location" => "Berlin Convention Center",
        "target" => "modal",
        "past_events" => TRUE,
        "icons" => TRUE,
      ]],
    ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_atc_known addtocal enabled (label=Save the date, location=Berlin Convention Center, target=modal, past_events=true)"
