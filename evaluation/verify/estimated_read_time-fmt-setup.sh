#!/usr/bin/env bash
# Introspection SETUP: add estimated_read_time field field_ert_fmt to Article and configure the
# default view display formatter's tokenized_string to '@minutes minute read time', so the
# agent can read back the display string. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_fmt")) {
    FieldStorageConfig::create(["field_name" => "field_ert_fmt", "entity_type" => "node", "type" => "estimated_read_time"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_fmt")) {
    FieldConfig::create(["field_name" => "field_ert_fmt", "entity_type" => "node", "bundle" => "article", "label" => "Fmt Read Time"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_ert_fmt", [
    "type" => "estimated_read_time_text",
    "settings" => ["tokenized_string" => "@minutes minute read time"],
    "region" => "content", "weight" => 50,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ert_fmt formatter tokenized_string='@minutes minute read time'"
