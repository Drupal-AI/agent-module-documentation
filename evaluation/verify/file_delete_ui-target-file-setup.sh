#!/usr/bin/env bash
# Introspection SETUP: create a managed file entity with a known filename so an agent can look
# it up on the live site and report its delete-form URL (/file/{fid}/delete). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  use Drupal\Core\File\FileSystemInterface;
  $fs = \Drupal::service("file_system");
  $dir = "public://file_delete_ui_eval";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $uri = $dir . "/fdu_eval_lookup.txt";
  file_put_contents($uri, "file_delete_ui eval lookup");
  $ids = \Drupal::entityTypeManager()->getStorage("file")->getQuery()
    ->accessCheck(FALSE)->condition("filename", "fdu_eval_lookup.txt")->execute();
  if (empty($ids)) {
    File::create(["uri" => $uri, "filename" => "fdu_eval_lookup.txt", "status" => 1])->save();
  }
' >/dev/null 2>&1
echo "setup: managed file fdu_eval_lookup.txt created"
