#!/usr/bin/env bash
# Introspection CLEANUP: restore media_directories.settings to the shipped baseline
# (directory_taxonomy unset, all_files_in_root FALSE) and remove the md_eval_dirs vocabulary
# and its terms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;

  \Drupal::configFactory()->getEditable("media_directories.settings")
    ->set("directory_taxonomy", NULL)
    ->set("all_files_in_root", FALSE)
    ->save();

  $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "md_eval_dirs"]);
  foreach ($terms as $term) { $term->delete(); }
  if ($v = Vocabulary::load("md_eval_dirs")) { $v->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: media_directories.settings restored, md_eval_dirs vocabulary removed"
