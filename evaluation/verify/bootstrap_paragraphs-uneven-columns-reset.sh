#!/usr/bin/env bash
# Execution RESET for "build a two-uneven-columns Bootstrap Paragraph".
# Ensures container field field_bp_uneven_sections exists on node.article and that the Article
# node "BP Hard Uneven Page" exists with that field EMPTY, so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;

  if (!FieldStorageConfig::loadByName("node", "field_bp_uneven_sections")) {
    FieldStorageConfig::create([
      "field_name" => "field_bp_uneven_sections", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bp_uneven_sections")) {
    FieldConfig::create([
      "field_name" => "field_bp_uneven_sections", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Uneven Sections",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => ["negate" => 0]],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bp_uneven_sections", [
    "type" => "entity_reference_paragraphs", "weight" => 62, "region" => "content",
    "settings" => [
      "title" => "Section", "title_plural" => "Sections",
      "edit_mode" => "closed", "add_mode" => "dropdown",
      "form_display_mode" => "default", "default_paragraph_type" => "_none",
    ],
  ])->save();

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Uneven Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_uneven_sections") as $item) {
      if ($col = $item->entity) {
        if ($col->hasField("bp_column_content_2")) {
          foreach ($col->get("bp_column_content_2") as $child) {
            if ($child->entity) { $child->entity->delete(); }
          }
        }
        $col->delete();
      }
    }
    $n->delete();
  }
  Node::create([
    "type" => "article", "title" => "BP Hard Uneven Page", "status" => 1,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'BP Hard Uneven Page' exists with field_bp_uneven_sections EMPTY"
