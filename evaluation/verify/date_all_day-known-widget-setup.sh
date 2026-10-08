#!/usr/bin/env bash
# Introspection SETUP: create a daterange field field_dad_known on Article, put the
# date_all_day widget (daterange_all_day) on the default FORM display and the
# daterange_all_day_default formatter on the default VIEW display with a known
# date_only_format, so the agent can read the configured all-day settings back off the
# live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dad_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_dad_known", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dad_known")) {
    FieldConfig::create([
      "field_name" => "field_dad_known", "entity_type" => "node",
      "bundle" => "article", "label" => "DAD Known Event Dates",
      "settings" => ["optional_end_date" => TRUE],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dad_known", [
    "type" => "daterange_all_day", "weight" => 70, "region" => "content",
    "settings" => [], "third_party_settings" => [],
  ])->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_dad_known", [
    "type" => "daterange_all_day_default", "label" => "above", "weight" => 70, "region" => "content",
    "settings" => [
      "timezone_override" => "", "format_type" => "long", "separator" => "to",
      "date_only_format" => "html_date",
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dad_known widget=daterange_all_day formatter=daterange_all_day_default date_only_format=html_date"
