#!/usr/bin/env bash
# Introspection SETUP (bp_media): create an Image media entity and reference it from a real
# bp_media paragraph on an article, so an agent can read back which media the section shows
# and how wide it is. Creates a PNG file, media "BP Media Known Image", field_bpmedia_known
# on Article limited to bp_media, node "BP Media Known Section", and a bp_media paragraph with
# bp_width = paragraph--width--wide and bp_header = "Known Media Section". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\file\Entity\File;
  use Drupal\media\Entity\Media;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpmedia_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpmedia_known", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpmedia_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpmedia_known", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Media Known",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_media" => "bp_media"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpmedia_known", ["type" => "entity_reference_paragraphs", "weight" => 66, "region" => "content"])->save();
  // Clear previous run.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Known Section")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Known Media Section")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  // Reuse or create the media entity.
  $mids = \Drupal::entityQuery("media")->accessCheck(FALSE)->condition("name", "BP Media Known Image")->execute();
  if ($mids) { $media = Media::load(reset($mids)); }
  else {
    $dir = "public://bpmedia-eval";
    \Drupal::service("file_system")->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
    $png = base64_decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==");
    $uri = \Drupal::service("file.repository")->writeData($png, $dir . "/bpmedia-eval.png", \Drupal\Core\File\FileExists::Replace);
    $media = Media::create([
      "bundle" => "image", "name" => "BP Media Known Image", "status" => 1,
      "field_media_image" => ["target_id" => $uri->id(), "alt" => "BP Media eval image"],
    ]);
    $media->save();
  }
  $p = Paragraph::create([
    "type" => "bp_media",
    "bp_media" => ["target_id" => $media->id()],
    "bp_header" => "Known Media Section",
    "bp_width" => "paragraph--width--wide",
    "bp_margin" => "mt-5 mb-5",
  ]);
  $p->save();
  $n = Node::create(["type" => "article", "title" => "BP Media Known Section", "status" => 1]);
  $n->set("field_bpmedia_known", [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]]);
  $n->save();
  print "media=" . $media->id() . " paragraph=" . $p->id() . " node=" . $n->id() . "\n";
'
drush cr >/dev/null 2>&1
echo "setup: 'BP Media Known Section' has a bp_media paragraph -> media 'BP Media Known Image', bp_width=paragraph--width--wide"
