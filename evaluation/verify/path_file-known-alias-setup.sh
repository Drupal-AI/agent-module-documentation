#!/usr/bin/env bash
# Introspection SETUP: create a managed file + a published path_file_entity named "PF Eval Doc"
# whose URL alias is /pf-eval-doc, so an agent can inspect which alias serves the file.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $dir = "public://pf_eval";
  \Drupal::service("file_system")->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY | \Drupal\Core\File\FileSystemInterface::MODIFY_PERMISSIONS);
  $uri = $dir . "/pf-eval-doc.txt";
  file_put_contents(\Drupal::service("file_system")->realpath($dir) . "/pf-eval-doc.txt", "PF eval marker file\n");
  $files = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]);
  $file = $files ? reset($files) : File::create(["uri" => $uri, "status" => 1]);
  if ($file->isNew()) { $file->save(); }
  $store = \Drupal::entityTypeManager()->getStorage("path_file_entity");
  $existing = $store->loadByProperties(["name" => "PF Eval Doc"]);
  if (!$existing) {
    $pf = $store->create([
      "name" => "PF Eval Doc", "fid" => $file->id(), "status" => 1,
      "path" => ["alias" => "/pf-eval-doc"],
    ]);
    $pf->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: path_file_entity 'PF Eval Doc' created with alias /pf-eval-doc"
