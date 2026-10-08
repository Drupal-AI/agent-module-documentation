#!/usr/bin/env bash
# Introspection SETUP: create a saved entity_export_csv config entity eec_known targeting
# node/article, delimiter '|', exporting the title field with default_export. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_export_csv");
  if (!$s->load("eec_known")) {
    $s->create([
      "id" => "eec_known", "label" => "EEC Known", "status" => TRUE,
      "entity_type_id" => "node", "bundle" => "article", "delimiter" => "|",
      "fields" => [
        "title" => [
          "enable" => TRUE, "order" => 0, "exporter" => "default_export",
          "form" => ["options" => [
            "header" => "label", "property" => ["value" => "value"],
            "property_separator" => ", ", "property_separate_column" => 0, "format" => "",
          ]],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_export_csv config eec_known (node/article, delimiter=|, title->default_export)"
