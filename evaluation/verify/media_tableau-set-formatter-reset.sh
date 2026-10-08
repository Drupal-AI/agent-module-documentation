#!/usr/bin/env bash
# Execution RESET: ensure a string field field_mtb_task exists on Article and force its default
# view-display component to the plain 'string' formatter (NOT media_tableau), so verify FAILS
# until the agent switches it to media_tableau with the toolbar on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mtb_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_mtb_task", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mtb_task")) {
    FieldConfig::create([
      "field_name" => "field_mtb_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Tableau URL",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mtb_task", [
    "type" => "string", "label" => "above", "weight" => 50, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_mtb_task uses plain string formatter (not media_tableau)"
