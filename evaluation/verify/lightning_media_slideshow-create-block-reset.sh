#!/usr/bin/env bash
# Execution RESET: delete any block content labelled 'LM Slideshow Task' and (re)create two
# Document media fixtures - 'LM Slide A' and 'LM Slide B' - for the agent to reference.
# Verify FAILS in this state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\Media;
  use Drupal\file\Entity\File;
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "LM Slideshow Task"]) as $b) { $b->delete(); }
  $fs_service = \Drupal::service("file_system");
  $dir = "public://lm-eval";
  $fs_service->prepareDirectory($dir, $fs_service::CREATE_DIRECTORY | $fs_service::MODIFY_PERMISSIONS);
  $make_file = function ($name) use ($dir) {
    $uri = "$dir/$name";
    if (!file_exists($uri)) { file_put_contents($uri, "lightning media slideshow fixture\n"); }
    $existing = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]);
    if ($existing) { return reset($existing); }
    $f = File::create(["uri" => $uri, "status" => 1]);
    $f->save();
    return $f;
  };
  $storage = \Drupal::entityTypeManager()->getStorage("media");
  foreach (["LM Slide A" => "lm-slide-a.txt", "LM Slide B" => "lm-slide-b.txt"] as $name => $filename) {
    $found = $storage->loadByProperties(["name" => $name]);
    $media = $found ? reset($found) : Media::create(["bundle" => "document", "name" => $name]);
    $media->set("field_media_document", ["target_id" => $make_file($filename)->id()]);
    $media->save();
  }
' >/dev/null 2>&1
echo "reset: no 'LM Slideshow Task' block; media 'LM Slide A' and 'LM Slide B' present"
