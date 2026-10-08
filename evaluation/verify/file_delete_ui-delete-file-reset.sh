#!/usr/bin/env bash
# Execution RESET: (re)create a managed file entity fdu_eval_target.txt so it exists, meaning
# verify FAILS until the agent deletes it using the module's file-delete capability.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  use Drupal\Core\File\FileSystemInterface;
  $fs = \Drupal::service("file_system");
  $dir = "public://file_delete_ui_eval";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $uri = $dir . "/fdu_eval_target.txt";
  file_put_contents($uri, "file_delete_ui eval target");
  $ids = \Drupal::entityTypeManager()->getStorage("file")->getQuery()
    ->accessCheck(FALSE)->condition("filename", "fdu_eval_target.txt")->execute();
  if (empty($ids)) {
    File::create(["uri" => $uri, "filename" => "fdu_eval_target.txt", "status" => 1])->save();
  }
' >/dev/null 2>&1
echo "reset: managed file fdu_eval_target.txt (re)created"
