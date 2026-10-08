#!/usr/bin/env bash
# Introspection SETUP: create two media items of the Document type - one visible in the
# media library and one with Lightning Media's field_media_in_library switched off - so the
# agent can read the live field values and say which asset is hidden. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\Media;
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  $dir = "public://lm-eval";
  $fs->prepareDirectory($dir, $fs::CREATE_DIRECTORY | $fs::MODIFY_PERMISSIONS);
  $make_file = function ($name) use ($dir) {
    $uri = "$dir/$name";
    if (!file_exists($uri)) { file_put_contents($uri, "lightning media eval fixture\n"); }
    $existing = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]);
    if ($existing) { return reset($existing); }
    $f = File::create(["uri" => $uri, "status" => 1]);
    $f->save();
    return $f;
  };
  $specs = [
    "LM Visible Asset" => [TRUE, "lm-visible.txt"],
    "LM Hidden Asset" => [FALSE, "lm-hidden.txt"],
  ];
  $storage = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($specs as $name => [$in_library, $filename]) {
    $found = $storage->loadByProperties(["name" => $name]);
    $media = $found ? reset($found) : Media::create(["bundle" => "document", "name" => $name]);
    $media->set("field_media_document", ["target_id" => $make_file($filename)->id()]);
    $media->set("field_media_in_library", $in_library);
    $media->save();
  }
' >/dev/null 2>&1
echo "setup: media 'LM Visible Asset' (in library) and 'LM Hidden Asset' (field_media_in_library = FALSE)"
