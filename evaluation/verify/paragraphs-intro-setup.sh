#!/usr/bin/env bash
# Introspection SETUP (medium tier) — installs a KNOWN Paragraphs configuration to the
# live site so the agent can inspect it with drush and answer questions about it:
#   - paragraph type  eval_intro_pt  with a formatted-text field  field_intro_body
#   - node.article reference field  field_intro_sections : entity_reference_revisions
#     -> paragraph, cardinality 3, handler default:paragraph
# Idempotent: any prior copy is torn down first, then rebuilt from scratch. The paired
# paragraphs-intro-cleanup.sh restores baseline afterwards.
set -uo pipefail
cd /var/www/html
# Split across two php:eval requests on purpose: field storages must be persisted in a
# prior request before their field configs are created, or the entity_reference_revisions
# config save fails silently within the same request.
# Pass 1 — tear down any prior copy, then create the paragraph type + both field storages.
drush php:eval '
  $efm = \Drupal::entityTypeManager();
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_intro_sections")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_intro_sections")) { $fs->delete(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "eval_intro_pt", "field_intro_body")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", "field_intro_body")) { $fs->delete(); }
  if ($pt = $efm->getStorage("paragraphs_type")->load("eval_intro_pt")) { $pt->delete(); }

  $efm->getStorage("paragraphs_type")->create(["id" => "eval_intro_pt", "label" => "Eval Intro PT"])->save();
  \Drupal\field\Entity\FieldStorageConfig::create([
    "field_name" => "field_intro_body", "entity_type" => "paragraph", "type" => "text_long",
  ])->save();
  \Drupal\field\Entity\FieldStorageConfig::create([
    "field_name" => "field_intro_sections", "entity_type" => "node",
    "type" => "entity_reference_revisions", "cardinality" => 3,
    "settings" => ["target_type" => "paragraph"],
  ])->save();
' >/dev/null 2>&1
# Pass 2 — create both field configs now that their storages exist.
drush php:eval '
  \Drupal\field\Entity\FieldConfig::create([
    "field_name" => "field_intro_body", "entity_type" => "paragraph", "bundle" => "eval_intro_pt",
    "label" => "Intro body",
  ])->save();
  \Drupal\field\Entity\FieldConfig::create([
    "field_name" => "field_intro_sections", "entity_type" => "node", "bundle" => "article",
    "label" => "Intro sections",
    "settings" => ["handler" => "default:paragraph", "handler_settings" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eval_intro_pt (+field_intro_body) and node.article field_intro_sections (ERR->paragraph, cardinality 3, handler default:paragraph) installed"
