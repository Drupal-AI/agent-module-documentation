#!/usr/bin/env bash
# Execution RESET (bp_media): provide an empty paragraphs field field_bpmedia_build on Article
# that accepts the Media bundle, plus a ready-made Image media entity "BP Media Build Image"
# for the agent to reference. Deletes any node titled "BP Media Build Target" and any bp_media
# paragraph headed "Product Gallery". verify FAILS here. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\media\Entity\Media;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpmedia_build")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpmedia_build", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpmedia_build");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpmedia_build", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Media Build",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_media" => "bp_media"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpmedia_build", ["type" => "entity_reference_paragraphs", "weight" => 68, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Build Target")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Product Gallery")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $mids = \Drupal::entityQuery("media")->accessCheck(FALSE)->condition("name", "BP Media Build Image")->execute();
  if (!$mids) {
    $dir = "public://bpmedia-eval";
    \Drupal::service("file_system")->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
    $png = base64_decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==");
    $file = \Drupal::service("file.repository")->writeData($png, $dir . "/bpmedia-build.png", \Drupal\Core\File\FileExists::Replace);
    Media::create([
      "bundle" => "image", "name" => "BP Media Build Image", "status" => 1,
      "field_media_image" => ["target_id" => $file->id(), "alt" => "BP Media build image"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpmedia_build empty; media 'BP Media Build Image' available; no build-target node"
