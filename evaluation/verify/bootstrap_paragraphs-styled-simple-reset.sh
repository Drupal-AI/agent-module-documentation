#!/usr/bin/env bash
# Execution RESET for "add a styled bp_simple paragraph to an existing Article".
# Ensures the container field field_bp_hard_sections exists on node.article and that an
# Article node titled "BP Hard Styled Page" exists with that field EMPTY, so verify FAILS
# until the agent creates the paragraph. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;

  if (!FieldStorageConfig::loadByName("node", "field_bp_hard_sections")) {
    FieldStorageConfig::create([
      "field_name" => "field_bp_hard_sections", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bp_hard_sections")) {
    FieldConfig::create([
      "field_name" => "field_bp_hard_sections", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Hard Sections",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => ["negate" => 0]],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bp_hard_sections", [
    "type" => "entity_reference_paragraphs", "weight" => 61, "region" => "content",
    "settings" => [
      "title" => "Section", "title_plural" => "Sections",
      "edit_mode" => "closed", "add_mode" => "dropdown",
      "form_display_mode" => "default", "default_paragraph_type" => "_none",
    ],
  ])->save();

  // Remove any paragraphs from a previous attempt, then re-create the node empty.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Styled Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) {
    foreach ($n->get("field_bp_hard_sections") as $item) {
      if ($item->entity) { $item->entity->delete(); }
    }
    $n->delete();
  }
  Node::create([
    "type" => "article", "title" => "BP Hard Styled Page", "status" => 1,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'BP Hard Styled Page' exists with field_bp_hard_sections EMPTY"
