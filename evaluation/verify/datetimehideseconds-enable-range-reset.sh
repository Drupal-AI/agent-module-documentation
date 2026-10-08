#!/usr/bin/env bash
# Execution RESET: ensure a Datetime Range field field_dhs_period exists on Article with the
# daterange_default widget on the default form display, and force datetimehideseconds
# "Hide seconds" OFF (so verify FAILS until the agent enables it). The daterange widget
# extends DateTimeWidgetBase, so the module's checkbox applies to it and to both the start and
# end time inputs. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dhs_period")) {
    FieldStorageConfig::create([
      "field_name" => "field_dhs_period", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dhs_period")) {
    FieldConfig::create([
      "field_name" => "field_dhs_period", "entity_type" => "node",
      "bundle" => "article", "label" => "Event Period",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dhs_period", [
    "type" => "daterange_default", "weight" => 52, "region" => "content",
    "third_party_settings" => ["datetimehideseconds" => ["hide" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dhs_period (daterange_default) present with hide=FALSE"
