#!/usr/bin/env bash
# Introspection SETUP: create a field_token_value field field_ftv_known on Article with a known
# token string, and render it on the default view display with the 'blockquote' wrapper. Lets an
# agent read back the field_value token and the formatter wrapper. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftv_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ftv_known", "entity_type" => "node", "type" => "field_token_value",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftv_known")) {
    FieldConfig::create([
      "field_name" => "field_ftv_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known token field",
      "settings" => ["field_value" => "[node:title] — [node:nid]", "remove_empty" => TRUE],
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $vd->setComponent("field_ftv_known", [
      "type" => "field_token_value_text", "weight" => 50, "region" => "content",
      "settings" => ["wrapper" => "blockquote", "link" => FALSE], "label" => "hidden",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ftv_known (field_value=[node:title] — [node:nid], wrapper=blockquote)"
