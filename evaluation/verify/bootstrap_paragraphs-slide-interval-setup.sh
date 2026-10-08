#!/usr/bin/env bash
# Introspection SETUP: create an Article node "BP Eval Carousel Page" holding a bp_carousel
# Bootstrap Paragraph whose bp_slide_interval is set to the known value 6000 ("6 Seconds"),
# with two bp_simple slides in bp_slide_content. The agent must inspect the live paragraph to
# report the configured rotation interval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\node\Entity\Node;

  if (!FieldStorageConfig::loadByName("node", "field_bp_eval_carousel")) {
    FieldStorageConfig::create([
      "field_name" => "field_bp_eval_carousel", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bp_eval_carousel")) {
    FieldConfig::create([
      "field_name" => "field_bp_eval_carousel", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Eval Carousel",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => ["negate" => 0]],
    ])->save();
  }

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Eval Carousel Page")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }

  $slides = [];
  foreach (["First slide", "Second slide"] as $txt) {
    $s = Paragraph::create([
      "type" => "bp_simple",
      "bp_text" => ["value" => "<p>" . $txt . "</p>", "format" => "basic_html"],
    ]);
    $s->save();
    $slides[] = ["target_id" => $s->id(), "target_revision_id" => $s->getRevisionId()];
  }

  $c = Paragraph::create([
    "type" => "bp_carousel",
    "bp_slide_interval" => "6000",
    "bp_width" => "paragraph--width--full",
    "bp_slide_content" => $slides,
  ]);
  $c->save();

  Node::create([
    "type" => "article", "title" => "BP Eval Carousel Page", "status" => 1,
    "field_bp_eval_carousel" => [["target_id" => $c->id(), "target_revision_id" => $c->getRevisionId()]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'BP Eval Carousel Page' has a bp_carousel paragraph with bp_slide_interval=6000"
