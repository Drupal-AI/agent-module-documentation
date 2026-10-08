#!/usr/bin/env bash
# Introspection SETUP: point media_directories at a namespaced vocabulary md_eval_filed,
# create the folders "Brochures" and "Photos", and file three image media items:
# two into Photos ("MD eval photo A", "MD eval photo B") and one into Brochures
# ("MD eval brochure"). A fourth item ("MD eval unfiled") is left in the root (directory
# NULL). The agent must query the live `directory` base field to find them.
# Cleanup restores the shipped baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\file\Entity\File;
  use Drupal\media\Entity\Media;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  $config = \Drupal::configFactory()->getEditable("media_directories.settings");

  if (!Vocabulary::load("md_eval_filed")) {
    Vocabulary::create(["vid" => "md_eval_filed", "name" => "MD eval filed"])->save();
  }
  $config->set("directory_taxonomy", "md_eval_filed")->set("all_files_in_root", FALSE)->save();

  $term_storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $tids = [];
  foreach (["Brochures", "Photos"] as $name) {
    $found = $term_storage->loadByProperties(["vid" => "md_eval_filed", "name" => $name]);
    if ($found) { $tids[$name] = (int) reset($found)->id(); continue; }
    $t = Term::create(["vid" => "md_eval_filed", "name" => $name]);
    $t->save();
    $tids[$name] = (int) $t->id();
  }

  $fs = \Drupal::service("file_system");
  $dir = "public://md-eval";
  $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);

  $make = function (string $name, ?int $tid) use ($fs, $dir, $term_storage) {
    $existing = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => $name]);
    if ($existing) { return; }
    $uri = $dir . "/" . preg_replace("/[^a-z0-9]+/i", "-", strtolower($name)) . ".png";
    if (!file_exists($uri)) {
      $im = imagecreatetruecolor(20, 20);
      $tmp = $fs->tempnam("temporary://", "mdeval");
      imagepng($im, $fs->realpath($tmp));
      $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
    }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    $media = Media::create([
      "bundle" => "image",
      "name" => $name,
      "field_media_image" => ["target_id" => $file->id(), "alt" => $name],
      "status" => 1,
    ]);
    if ($tid !== NULL) { $media->set("directory", $tid); }
    $media->save();
  };

  $make("MD eval photo A", $tids["Photos"]);
  $make("MD eval photo B", $tids["Photos"]);
  $make("MD eval brochure", $tids["Brochures"]);
  $make("MD eval unfiled", NULL);
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "setup: md_eval_filed vocabulary + 2 media in Photos, 1 in Brochures, 1 in root"
