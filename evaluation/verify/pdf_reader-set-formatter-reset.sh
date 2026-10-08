#!/usr/bin/env bash
# Execution RESET (pdf_reader): ensure a plain-text field field_pdf_task exists on Article and its
# Article default view-display formatter is the plain 'string' formatter (NOT PDF Reader), so
# verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_pdf_task")) {
    FieldStorageConfig::create(["field_name" => "field_pdf_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_pdf_task")) {
    FieldConfig::create(["field_name" => "field_pdf_task", "entity_type" => "node", "bundle" => "article", "label" => "Datasheet URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_pdf_task", ["type" => "string", "label" => "above", "region" => "content", "weight" => 62, "settings" => []])->save();
' >/dev/null 2>&1 || true
echo "reset: field_pdf_task present with plain string formatter (not PDF Reader)"
exit 0
