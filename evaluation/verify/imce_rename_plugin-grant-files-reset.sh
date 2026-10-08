#!/usr/bin/env bash
# imce_rename_plugin reset: create/replace IMCE profile imcerp_task with rename_files=FALSE rename_folders=FALSE on its folder.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imce_profile");
  if ($p = $s->load("imcerp_task")) { $p->delete(); }
  $s->create([
    "id" => "imcerp_task", "label" => "imcerp_task",
    "conf" => ["folders" => [["path" => ".", "permissions" => [
      "browse_files" => TRUE, "browse_subfolders" => TRUE,
      "rename_files" => FALSE, "rename_folders" => FALSE,
    ]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: imce.profile.imcerp_task rename_files=FALSE rename_folders=FALSE"
