#!/usr/bin/env bash
# Execution RESET: ensure paragraph type pp_task and Paragraphs field field_pp_task exist on
# Article, and force the form-display widget back to the STOCK "paragraphs" widget so verify
# FAILS until the agent switches it to paragraphs_previewer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pp_task")) {
    ParagraphsType::create(["id" => "pp_task", "label" => "PP Task"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_pp_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_pp_task", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pp_task")) {
    FieldConfig::create([
      "field_name" => "field_pp_task", "entity_type" => "node", "bundle" => "article",
      "label" => "Task Sections",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => ["target_bundles" => ["pp_task" => "pp_task"]]],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pp_task", ["type" => "paragraphs", "weight" => 62, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_pp_task widget forced back to stock paragraphs"
