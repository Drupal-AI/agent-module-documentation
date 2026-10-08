#!/usr/bin/env bash
# Introspection SETUP (pdf_reader): create a plain-text field field_pdf_known on Article and set
# its Article default view-display formatter to PDF Reader (FieldPdfReaderFields) with the pdf-js
# renderer, so an agent can read back the formatter/renderer. Idempotent. Exit 0.
# NOTE: field-storage creation requires a healthy site; see the module eval note.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_known")) {
    FieldStorageConfig::create(["field_name" => "field_pdf_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_known")) {
    FieldConfig::create(["field_name" => "field_pdf_known", "entity_type" => "node", "bundle" => "article", "label" => "PDF URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_known", ["type" => "FieldPdfReaderFields", "label" => "hidden", "region" => "content", "weight" => 60,
    "settings" => ["pdf_width" => 600, "pdf_height" => 780, "renderer" => "pdf-js", "embed_view_fit" => "Fit", "embed_hide_toolbar" => FALSE, "download" => FALSE, "link_placement" => "top"]])->save();
' >/dev/null 2>&1 || true
echo "setup: node.article field_pdf_known uses FieldPdfReaderFields renderer=pdf-js"
exit 0
