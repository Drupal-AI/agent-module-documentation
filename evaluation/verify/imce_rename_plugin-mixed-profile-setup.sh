#!/usr/bin/env bash
# imce_rename_plugin setup: create/replace IMCE profile imcerp_mixed with rename_files=TRUE rename_folders=FALSE on its folder.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imce_profile");
  if ($p = $s->load("imcerp_mixed")) { $p->delete(); }
  $s->create([
    "id" => "imcerp_mixed", "label" => "imcerp_mixed",
    "conf" => ["folders" => [["path" => ".", "permissions" => [
      "browse_files" => TRUE, "browse_subfolders" => TRUE,
      "rename_files" => TRUE, "rename_folders" => FALSE,
    ]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imce.profile.imcerp_mixed rename_files=TRUE rename_folders=FALSE"
