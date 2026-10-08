#!/usr/bin/env bash
# Introspection CLEANUP: delete the four MD eval media items (and their files), the
# md_eval_filed vocabulary and its terms, and restore media_directories.settings to the
# shipped baseline (directory_taxonomy unset, all_files_in_root FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;

  $media_storage = \Drupal::entityTypeManager()->getStorage("media");
  foreach (["MD eval photo A", "MD eval photo B", "MD eval brochure", "MD eval unfiled"] as $name) {
    foreach ($media_storage->loadByProperties(["name" => $name]) as $media) {
      $file = $media->get("field_media_image")->entity;
      $media->delete();
      if ($file) { $file->delete(); }
    }
  }

  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "md_eval_filed"]) as $term) {
    $term->delete();
  }
  if ($v = Vocabulary::load("md_eval_filed")) { $v->delete(); }
  \Drupal::configFactory()->getEditable("media_directories.settings")
    ->set("directory_taxonomy", NULL)
    ->set("all_files_in_root", FALSE)
    ->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: MD eval media + md_eval_filed vocabulary removed, settings restored"
