#!/usr/bin/env bash
# Execution VERIFY for "hide the core Media/Files tabs with the deprecated UI submodule".
# PASS when media_directories_ui.settings has hide_media_library_media_tab,
# hide_media_library_files_tab and hide_admin_toolbar_links all TRUE, AND the hook really
# removes the tabs: calling MediaDirectoriesUiHooks::menuLocalTasksAlter() on a synthetic
# tabs array drops both entity.media.collection and views_view:view.files.page_1.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $config = \Drupal::config("media_directories_ui.settings");
  $media = $config->get("hide_media_library_media_tab") === TRUE;
  $files = $config->get("hide_media_library_files_tab") === TRUE;
  $toolbar = $config->get("hide_admin_toolbar_links") === TRUE;

  $data = ["tabs" => [0 => [
    "entity.media.collection" => ["#weight" => 0],
    "views_view:view.files.page_1" => ["#weight" => 1],
    "system.admin_content" => ["#weight" => 2],
  ]]];
  $cacheability = new \Drupal\Core\Cache\CacheableMetadata();
  \Drupal\media_directories_ui\Hook\MediaDirectoriesUiHooks::menuLocalTasksAlter($data, "system.admin_content", $cacheability);
  $removed = !isset($data["tabs"][0]["entity.media.collection"])
    && !isset($data["tabs"][0]["views_view:view.files.page_1"])
    && isset($data["tabs"][0]["system.admin_content"]);

  $ok = $media && $files && $toolbar && $removed;
  print ($ok ? "PASS" : "FAIL")
    . " hide_media_tab=" . var_export($config->get("hide_media_library_media_tab"), TRUE)
    . " hide_files_tab=" . var_export($config->get("hide_media_library_files_tab"), TRUE)
    . " hide_toolbar=" . var_export($config->get("hide_admin_toolbar_links"), TRUE)
    . " tabs_removed=" . var_export($removed, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
