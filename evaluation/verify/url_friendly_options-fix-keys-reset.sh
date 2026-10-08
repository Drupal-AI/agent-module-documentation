#!/usr/bin/env bash
# Execution RESET: (re)create field_ufo_fix on node.article as a list_string field with
# NON-URL-friendly keys (underscores), so verify FAILS until the agent makes every key
# URL-friendly. Idempotent (rewrites the allowed_values each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_ufo_fix");
  if (!$fs) {
    $fs = FieldStorageConfig::create([
      "field_name" => "field_ufo_fix", "entity_type" => "node", "type" => "list_string",
    ]);
  }
  $fs->setSetting("allowed_values", ["bad_key_1" => "First", "bad_key_2" => "Second"]);
  $fs->save();
  if (!FieldConfig::loadByName("node", "article", "field_ufo_fix")) {
    FieldConfig::create([
      "field_name" => "field_ufo_fix", "entity_type" => "node",
      "bundle" => "article", "label" => "UFO Fix",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ufo_fix allowed_values keys = bad_key_1, bad_key_2 (non-URL-friendly)"
