#!/usr/bin/env bash
# Introspection SETUP: create TWO core File fields on Article — field_pdf_cover using the
# pdf module's `pdf_thumbnail` formatter (first page only) and field_pdf_scroll using
# `pdf_pages` (continuous scroll) — so the agent must inspect the live view display to tell
# which field renders every page.
# NOTE: field creation and display configuration are deliberately two separate drush calls —
# setting a component for a field created in the same PHP process saves against stale field
# definitions and the component is silently dropped. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $labels = ["field_pdf_cover" => "Cover Sheet", "field_pdf_scroll" => "Full Document"];
  foreach ($labels as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "file", "settings" => ["uri_scheme" => "public", "target_type" => "file"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => $label, "settings" => ["file_extensions" => "pdf", "file_directory" => "pdf-eval"],
      ])->save();
    }
  }
' >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_cover", [
    "type" => "pdf_thumbnail", "weight" => 61, "region" => "content", "label" => "hidden",
    "settings" => ["scale" => 1, "width" => "220px", "height" => ""],
  ]);
  $vd->setComponent("field_pdf_scroll", [
    "type" => "pdf_pages", "weight" => 62, "region" => "content", "label" => "hidden",
    "settings" => ["scale" => 1.25],
  ]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_pdf_cover=pdf_thumbnail, field_pdf_scroll=pdf_pages on node.article.default"
