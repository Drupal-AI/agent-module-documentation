#!/usr/bin/env bash
# Introspection SETUP: create an Article node "BP Eval Styled Page" carrying a bp_simple
# Bootstrap Paragraph whose shared style fields hold known values —
#   bp_width      = paragraph--width--medium
#   bp_background = paragraph--color paragraph--color--rgba-teal-strong
#   bp_margin     = mt-5 mb-5
# The agent must inspect the live paragraph entity to report the background value.
# Creates the container field field_bp_eval_styled on node.article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\node\Entity\Node;

  if (!FieldStorageConfig::loadByName("node", "field_bp_eval_styled")) {
    FieldStorageConfig::create([
      "field_name" => "field_bp_eval_styled", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bp_eval_styled")) {
    FieldConfig::create([
      "field_name" => "field_bp_eval_styled", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Eval Styled Sections",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => ["negate" => 0]],
    ])->save();
  }

  // Drop any previous run.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Eval Styled Page")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }

  $p = Paragraph::create([
    "type" => "bp_simple",
    "bp_header" => "Teal Section",
    "bp_text" => ["value" => "<p>Styled by Bootstrap Paragraphs.</p>", "format" => "basic_html"],
    "bp_width" => "paragraph--width--medium",
    "bp_background" => "paragraph--color paragraph--color--rgba-teal-strong",
    "bp_margin" => "mt-5 mb-5",
    "bp_padding" => "pt-3 pb-3",
  ]);
  $p->save();

  $n = Node::create([
    "type" => "article", "title" => "BP Eval Styled Page", "status" => 1,
    "field_bp_eval_styled" => [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]],
  ]);
  $n->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'BP Eval Styled Page' has a bp_simple paragraph with bp_background=...rgba-teal-strong"
