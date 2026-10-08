#!/usr/bin/env bash
# Introspection SETUP: create a role holding the DropzoneJS upload permission that Bulk Media
# Upload's route requires, so the agent must inspect live role configuration. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  if ($r = $storage->load("lm_bulk_uploader")) { $r->delete(); }
  $role = $storage->create(["id" => "lm_bulk_uploader", "label" => "LM Bulk Uploader"]);
  foreach (["dropzone upload files"] as $p) { $role->grantPermission($p); }
  $role->save();
' >/dev/null 2>&1
echo "setup: role lm_bulk_uploader created with 'dropzone upload files'"
