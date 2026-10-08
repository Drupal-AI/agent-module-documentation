#!/usr/bin/env bash
# Execution RESET for "show only the first page of field_pdf_preview as a thumbnail".
# Ensures a core File field field_pdf_preview exists on Article and forces its component on
# the TEASER view display to core's `file_default`, so verify FAILS until the agent switches
# it to the pdf module's pdf_thumbnail formatter with the requested scale/width.
# Also guarantees the article teaser display exists.
# NOTE: field creation and display configuration are deliberately two separate drush calls —
# setting a component for a field created in the same PHP process saves against stale field
# definitions and the component is silently dropped. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_preview")) {
    FieldStorageConfig::create([
      "field_name" => "field_pdf_preview", "entity_type" => "node",
      "type" => "file", "settings" => ["uri_scheme" => "public", "target_type" => "file"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_preview")) {
    FieldConfig::create([
      "field_name" => "field_pdf_preview", "entity_type" => "node", "bundle" => "article",
      "label" => "Datasheet", "settings" => ["file_extensions" => "pdf", "file_directory" => "pdf-eval"],
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $storage->load("node.article.teaser");
  if (!$vd) {
    $vd = $storage->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "teaser", "status" => TRUE,
    ]);
  }
  $vd->setComponent("field_pdf_preview", [
    "type" => "file_default", "weight" => 64, "region" => "content", "label" => "hidden",
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.teaser field_pdf_preview set back to core file_default formatter"
