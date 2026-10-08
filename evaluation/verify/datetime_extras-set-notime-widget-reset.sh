#!/usr/bin/env bash
# Execution RESET: create/ensure core datetime field field_dte_setw on Article with the CORE
# datetime_default widget on the default form display, so verify FAILS until the agent switches
# it to datetime_datelist_no_time. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dte_setw")) {
    FieldStorageConfig::create([
      "field_name" => "field_dte_setw", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dte_setw")) {
    FieldConfig::create([
      "field_name" => "field_dte_setw", "entity_type" => "node",
      "bundle" => "article", "label" => "Set Widget Date",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dte_setw", [
    "type" => "datetime_default", "region" => "content", "weight" => 50, "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dte_setw widget=datetime_default (core)"
