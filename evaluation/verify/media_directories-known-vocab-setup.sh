#!/usr/bin/env bash
# Introspection SETUP: create a namespaced vocabulary md_eval_dirs, point
# media_directories.settings:directory_taxonomy at it, turn all_files_in_root ON, and build a
# small folder tree. An inspecting agent must read the live config (and the resulting
# directory base-field settings) to answer. Cleanup restores the shipped baseline
# (directory_taxonomy unset, all_files_in_root FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;

  $config = \Drupal::configFactory()->getEditable("media_directories.settings");

  if (!Vocabulary::load("md_eval_dirs")) {
    Vocabulary::create(["vid" => "md_eval_dirs", "name" => "MD eval directories"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $existing = $storage->loadByProperties(["vid" => "md_eval_dirs", "name" => "Press"]);
  if (!$existing) {
    $press = Term::create(["vid" => "md_eval_dirs", "name" => "Press"]);
    $press->save();
    Term::create(["vid" => "md_eval_dirs", "name" => "Logos", "parent" => [$press->id()]])->save();
  }

  $config->set("directory_taxonomy", "md_eval_dirs")->set("all_files_in_root", TRUE)->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "setup: media_directories.settings directory_taxonomy=md_eval_dirs all_files_in_root=TRUE"
