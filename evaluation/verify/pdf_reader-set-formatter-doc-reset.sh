#!/usr/bin/env bash
# Execution RESET (pdf_reader, layman): ensure field_pdf_doc (string) exists on Article with the
# plain 'string' formatter so verify FAILS until switched to PDF Reader. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_doc")) {
    FieldStorageConfig::create(["field_name" => "field_pdf_doc", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_doc")) {
    FieldConfig::create(["field_name" => "field_pdf_doc", "entity_type" => "node", "bundle" => "article", "label" => "Document URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_doc", ["type" => "string", "label" => "above", "region" => "content", "weight" => 63, "settings" => []])->save();
' >/dev/null 2>&1 || true
echo "reset: field_pdf_doc present with plain string formatter"
exit 0
