#!/usr/bin/env bash
# Execution RESET for "wire Media Directories up to a folder vocabulary".
# Removes the md_task_dirs vocabulary and clears media_directories.settings back to an
# unconfigured state (directory_taxonomy unset, all_files_in_root FALSE) so verify FAILS on
# empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $config = \Drupal::configFactory()->getEditable("media_directories.settings");

  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "md_task_dirs"]) as $term) {
    $term->delete();
  }
  if ($v = Vocabulary::load("md_task_dirs")) { $v->delete(); }

  $config->set("directory_taxonomy", NULL)->set("all_files_in_root", FALSE)->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "reset: md_task_dirs removed, media_directories.settings cleared"
