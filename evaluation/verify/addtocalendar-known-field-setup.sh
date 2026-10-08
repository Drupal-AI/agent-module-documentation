#!/usr/bin/env bash
# Introspection SETUP: create a datetime field field_atc_known on Article and enable the
# addtocalendar third-party formatter setting on the default view display, with a distinctive
# button text, so an inspecting agent can read back which field has the button. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_atc_known", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_known")) {
    FieldConfig::create([
      "field_name" => "field_atc_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Event Date",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_known", [
    "type" => "datetime_default", "weight" => 50, "region" => "content", "label" => "above",
    "settings" => [], "third_party_settings" => ["addtocalendar" => [
      "addtocalendar_show" => 1,
      "addtocalendar_settings" => ["style" => "blue", "display_text" => "Save this date", "atc_privacy" => "public", "data_secure" => "auto"],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_atc_known datetime has addtocalendar_show=1 (text 'Save this date')"
