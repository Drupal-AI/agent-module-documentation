#!/usr/bin/env bash
# Introspection SETUP (medium tier) — installs a KNOWN asymmetric-widget configuration to
# the live site so the agent can inspect it with drush and answer questions about it:
#   - node.article reference field  field_asym_para : entity_reference_revisions ->
#     paragraph, unlimited cardinality, translatable
#   - node.article.default entity_FORM_display component for field_asym_para uses widget
#     `paragraphs_classic_asymmetric` with settings title="Chapter", edit_mode="closed"
# Idempotent: any prior copy is torn down first, then rebuilt. The paired
# paragraphs_asymmetric-introspect-cleanup.sh restores baseline afterwards.
set -uo pipefail
cd /var/www/html
# Pass 1 — tear down any prior copy, then create the field storage (must persist before
# the field config that references it, or the save fails silently in one request).
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_asym_para")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_asym_para")) { $fs->delete(); }
  \Drupal\field\Entity\FieldStorageConfig::create([
    "field_name" => "field_asym_para", "entity_type" => "node",
    "type" => "entity_reference_revisions", "cardinality" => -1,
    "settings" => ["target_type" => "paragraph"],
  ])->save();
' >/dev/null 2>&1
# Pass 2 — create the field config (translatable) now that the storage exists.
drush php:eval '
  \Drupal\field\Entity\FieldConfig::create([
    "field_name" => "field_asym_para", "entity_type" => "node", "bundle" => "article",
    "label" => "Asymmetric paragraphs", "translatable" => TRUE,
    "settings" => ["handler" => "default:paragraph", "handler_settings" => []],
  ])->save();
' >/dev/null 2>&1
# Pass 3 — point the Article form display at the module`s legacy asymmetric widget.
drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_asym_para", [
    "type" => "paragraphs_classic_asymmetric",
    "settings" => [
      "title" => "Chapter", "title_plural" => "Chapters",
      "edit_mode" => "closed", "add_mode" => "dropdown",
      "form_display_mode" => "default", "default_paragraph_type" => "",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_asym_para (ERR->paragraph, translatable) + form display widget paragraphs_classic_asymmetric (title=Chapter, edit_mode=closed) installed"
