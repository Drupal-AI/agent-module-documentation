#!/usr/bin/env bash
# Execution RESET for "build a directory-scoped media view".
# Deletes the md_task_media view so verify FAILS on empty state. Also ensures a folder
# vocabulary (md_view_dirs) is configured, so the module's Views handlers have a vocabulary
# to work with. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\views\Entity\View;

  if ($v = View::load("md_task_media")) { $v->delete(); }
  $config = \Drupal::configFactory()->getEditable("media_directories.settings");
  if (!Vocabulary::load("md_view_dirs")) {
    Vocabulary::create(["vid" => "md_view_dirs", "name" => "MD view directories"])->save();
  }
  $config->set("directory_taxonomy", "md_view_dirs")->set("all_files_in_root", FALSE)->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "reset: view md_task_media deleted; directory_taxonomy=md_view_dirs"
