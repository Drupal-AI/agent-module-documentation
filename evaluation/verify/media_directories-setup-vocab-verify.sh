#!/usr/bin/env bash
# Execution VERIFY for "wire Media Directories up to a folder vocabulary".
# PASS when, on the live site:
#   * a vocabulary md_task_dirs exists,
#   * media_directories.settings:directory_taxonomy === 'md_task_dirs',
#   * media_directories.settings:all_files_in_root === TRUE,
#   * the vocabulary contains a top-level term "Campaigns" with a child term "Spring",
#   * the media `directory` base field is actually rebound to md_task_dirs
#     (handler_settings.target_bundles), proving caches were rebuilt.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;

  $vocab = Vocabulary::load("md_task_dirs") !== NULL;
  $config = \Drupal::config("media_directories.settings");
  $taxonomy_ok = $config->get("directory_taxonomy") === "md_task_dirs";
  $root_ok = $config->get("all_files_in_root") === TRUE;

  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $parent = NULL;
  foreach ($storage->loadByProperties(["vid" => "md_task_dirs", "name" => "Campaigns"]) as $t) { $parent = $t; }
  $parent_ok = $parent !== NULL && (int) ($parent->get("parent")->target_id ?: 0) === 0;

  $child_ok = FALSE;
  if ($parent) {
    foreach ($storage->loadByProperties(["vid" => "md_task_dirs", "name" => "Spring"]) as $c) {
      if ((int) $c->get("parent")->target_id === (int) $parent->id()) { $child_ok = TRUE; }
    }
  }

  $defs = \Drupal::service("entity_field.manager")->getBaseFieldDefinitions("media");
  $field = $defs["directory"] ?? NULL;
  $bundles = $field ? array_keys((array) ($field->getSetting("handler_settings")["target_bundles"] ?? [])) : [];
  $field_ok = $field !== NULL
    && $field->getSetting("handler") === "media_directory:default"
    && in_array("md_task_dirs", $bundles, TRUE);

  $ok = $vocab && $taxonomy_ok && $root_ok && $parent_ok && $child_ok && $field_ok;
  print ($ok ? "PASS" : "FAIL")
    . " vocab=" . var_export($vocab, TRUE)
    . " directory_taxonomy=" . var_export($config->get("directory_taxonomy"), TRUE)
    . " all_files_in_root=" . var_export($config->get("all_files_in_root"), TRUE)
    . " Campaigns=" . var_export($parent_ok, TRUE)
    . " Spring_child=" . var_export($child_ok, TRUE)
    . " base_field_bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
