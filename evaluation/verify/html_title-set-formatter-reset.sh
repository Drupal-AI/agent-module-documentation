#!/usr/bin/env bash
# Execution RESET: ensure a plain string field field_hty_task exists on Article and force its
# default view-display formatter to the plain 'string' formatter (NOT html_title), so verify
# FAILS until the agent switches it. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_hty_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_hty_task", "entity_type" => "node",
      "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_hty_task")) {
    FieldConfig::create([
      "field_name" => "field_hty_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task HTML Subtitle",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_hty_task", ["type" => "string", "weight" => 51, "region" => "content", "label" => "above"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_hty_task uses plain string formatter"
