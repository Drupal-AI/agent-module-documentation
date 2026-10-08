#!/usr/bin/env bash
# Execution RESET for "render field_pdf_manual with the pdf.js viewer".
# Ensures a core File field field_pdf_manual exists on Article and forces its component on
# core.entity_view_display.node.article.default back to core's plain `file_default`
# formatter, so verify FAILS until the agent switches it to the pdf module's pdf_default
# and sets the viewer options.
# NOTE: field creation and display configuration are deliberately two separate drush calls —
# setting a component for a field created in the same PHP process saves against stale field
# definitions and the component is silently dropped. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_manual")) {
    FieldStorageConfig::create([
      "field_name" => "field_pdf_manual", "entity_type" => "node",
      "type" => "file", "settings" => ["uri_scheme" => "public", "target_type" => "file"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_manual")) {
    FieldConfig::create([
      "field_name" => "field_pdf_manual", "entity_type" => "node", "bundle" => "article",
      "label" => "Product Manual", "settings" => ["file_extensions" => "pdf", "file_directory" => "pdf-eval"],
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_manual", [
    "type" => "file_default", "weight" => 63, "region" => "content", "label" => "above",
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_pdf_manual set back to core file_default formatter"
