#!/usr/bin/env bash
# Execution RESET: ensure string field field_tff_task exists on Article and force its default
# view-display component to the plain 'string' formatter (NOT text_field_formatter), so verify
# FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tff_task")) {
    FieldStorageConfig::create(["field_name" => "field_tff_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tff_task")) {
    FieldConfig::create(["field_name" => "field_tff_task", "entity_type" => "node", "bundle" => "article", "label" => "TFF Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_tff_task", ["type" => "string", "label" => "above", "weight" => 50, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tff_task uses plain string formatter"
