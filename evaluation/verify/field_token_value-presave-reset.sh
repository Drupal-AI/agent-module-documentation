#!/usr/bin/env bash
# Execution RESET: ensure field_ftv_auto (token 'FTV:[node:title]') exists on Article, and delete
# any Article titled 'FTVNODE-alpha' so verify FAILS until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftv_auto")) {
    FieldStorageConfig::create([
      "field_name" => "field_ftv_auto", "entity_type" => "node", "type" => "field_token_value",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftv_auto")) {
    FieldConfig::create([
      "field_name" => "field_ftv_auto", "entity_type" => "node", "bundle" => "article",
      "label" => "Auto token field",
      "settings" => ["field_value" => "FTV:[node:title]", "remove_empty" => TRUE],
    ])->save();
  }
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","article")->condition("title","FTVNODE-alpha")->execute();
  if (!empty($ids)) {
    $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids);
    foreach ($nodes as $n) { $n->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ftv_auto present; no Article titled FTVNODE-alpha"
