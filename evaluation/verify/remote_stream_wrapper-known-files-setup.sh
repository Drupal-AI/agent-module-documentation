#!/usr/bin/env bash
# Introspection SETUP: create TWO permanent managed file entities on the live site — one whose
# URI is a remote http:// URL (handled by remote_stream_wrapper's HttpStreamWrapper) and one
# ordinary public:// file — so an inspecting agent must work out which one is remote.
# Uses the site's own internal hostname (http://web) so no external network is required.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $storage = \Drupal::entityTypeManager()->getStorage("file");
  foreach (["rsw_eval_remote.png", "rsw_eval_local.png"] as $name) {
    foreach ($storage->loadByProperties(["filename" => $name]) as $f) { $f->delete(); }
  }
  $dir = "public://rsw_eval";
  \Drupal::service("file_system")->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
  file_put_contents($dir . "/rsw_eval_local.png", file_get_contents("core/misc/druplicon.png"));
  File::create([
    "uri" => "http://web/core/misc/druplicon.png",
    "filename" => "rsw_eval_remote.png",
    "status" => 1,
  ])->save();
  File::create([
    "uri" => $dir . "/rsw_eval_local.png",
    "filename" => "rsw_eval_local.png",
    "status" => 1,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rsw_eval_remote.png (http:// URI) and rsw_eval_local.png (public:// URI) created"
