#!/usr/bin/env bash
# Introspection SETUP: create a core File field field_pdf_report on Article and configure the
# pdf module's `pdf_default` formatter on the default view display with a KNOWN set of
# pdf.js viewer options (initial page 7, zoom page-width, 900px tall). The agent must read
# core.entity_view_display.node.article.default to answer.
# NOTE: field creation and display configuration are deliberately two separate drush calls —
# setting a component for a field created in the same PHP process saves against stale field
# definitions and the component is silently dropped. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_report")) {
    FieldStorageConfig::create([
      "field_name" => "field_pdf_report", "entity_type" => "node",
      "type" => "file", "settings" => ["uri_scheme" => "public", "target_type" => "file"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_report")) {
    FieldConfig::create([
      "field_name" => "field_pdf_report", "entity_type" => "node", "bundle" => "article",
      "label" => "Annual Report", "settings" => ["file_extensions" => "pdf", "file_directory" => "pdf-eval"],
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_report", [
    "type" => "pdf_default", "weight" => 60, "region" => "content", "label" => "above",
    "settings" => [
      "keep_pdfjs" => TRUE, "width" => "100%", "height" => "900px",
      "page" => 7, "zoom" => "page-width", "custom_zoom" => NULL, "pagemode" => "thumbs",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_pdf_report uses pdf_default (page=7, zoom=page-width, pagemode=thumbs, height=900px)"
