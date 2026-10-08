#!/usr/bin/env bash
# imce_rename_plugin introspection SETUP: two profiles, only imcerp_b grants rename_files.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imce_profile");
  foreach (["imcerp_a" => FALSE, "imcerp_b" => TRUE] as $id => $rf) {
    if ($p = $s->load($id)) { $p->delete(); }
    $s->create(["id" => $id, "label" => $id, "conf" => ["folders" => [[
      "path" => ".", "permissions" => ["browse_files" => TRUE, "rename_files" => $rf, "rename_folders" => FALSE],
    ]]]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imcerp_a rename_files=FALSE, imcerp_b rename_files=TRUE"
