#!/usr/bin/env bash
# Execution CLEANUP for "build a directory-scoped media view": deletes the md_task_media
# view and the md_view_dirs vocabulary, and restores media_directories.settings to the
# shipped baseline (directory_taxonomy unset, all_files_in_root FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\views\Entity\View;

  if ($v = View::load("md_task_media")) { $v->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "md_view_dirs"]) as $term) {
    $term->delete();
  }
  if ($voc = Vocabulary::load("md_view_dirs")) { $voc->delete(); }
  \Drupal::configFactory()->getEditable("media_directories.settings")
    ->set("directory_taxonomy", NULL)
    ->set("all_files_in_root", FALSE)
    ->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: md_task_media view + md_view_dirs removed, settings restored"
