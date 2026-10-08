#!/usr/bin/env bash
# Introspection SETUP (pdf_reader): create field_pdf_render (string) on Article using the PDF
# Reader formatter with the direct-embed renderer and a download link. Agent reports the renderer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_render")) {
    FieldStorageConfig::create(["field_name" => "field_pdf_render", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_render")) {
    FieldConfig::create(["field_name" => "field_pdf_render", "entity_type" => "node", "bundle" => "article", "label" => "Brochure URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_render", ["type" => "FieldPdfReaderFields", "label" => "hidden", "region" => "content", "weight" => 61,
    "settings" => ["pdf_width" => 600, "pdf_height" => 780, "renderer" => "embed", "embed_view_fit" => "FitH", "embed_hide_toolbar" => TRUE, "download" => TRUE, "link_placement" => "bottom"]])->save();
' >/dev/null 2>&1 || true
echo "setup: field_pdf_render uses FieldPdfReaderFields renderer=embed download=1"
exit 0
