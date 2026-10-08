#!/usr/bin/env bash
# Execution RESET (hard tier) — establish a clean, known baseline where a paragraphs
# reference field EXISTS on Article but its form-display widget is NOT this module's
# asymmetric widget, so the verify script FAILs until the agent switches it. Creates:
#   - node.article field_asym_para : entity_reference_revisions -> paragraph, unlimited,
#     translatable
#   - node.article.default form display component field_asym_para using the stock stable
#     `paragraphs` widget (the non-asymmetric baseline the agent must change)
# Idempotent: prior copy is torn down and rebuilt each run.
set -uo pipefail
cd /var/www/html
# Pass 1 — tear down, create field storage.
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_asym_para")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_asym_para")) { $fs->delete(); }
  \Drupal\field\Entity\FieldStorageConfig::create([
    "field_name" => "field_asym_para", "entity_type" => "node",
    "type" => "entity_reference_revisions", "cardinality" => -1,
    "settings" => ["target_type" => "paragraph"],
  ])->save();
' >/dev/null 2>&1
# Pass 2 — field config (translatable).
drush php:eval '
  \Drupal\field\Entity\FieldConfig::create([
    "field_name" => "field_asym_para", "entity_type" => "node", "bundle" => "article",
    "label" => "Asymmetric paragraphs", "translatable" => TRUE,
    "settings" => ["handler" => "default:paragraph", "handler_settings" => []],
  ])->save();
' >/dev/null 2>&1
# Pass 3 — put the NON-asymmetric stock `paragraphs` widget on the form display.
drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_asym_para", ["type" => "paragraphs"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_asym_para created with the stock 'paragraphs' widget (not asymmetric)"
