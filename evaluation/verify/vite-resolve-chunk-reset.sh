#!/usr/bin/env bash
# Execution RESET: write a Vite manifest.json fixture (source entry src/app.ts -> built
# assets/app-XYZ789.js) into the public files dir, store its absolute path in state
# vite_eval_hard_manifest, and CLEAR the output state vite_eval_hard_result so verify FAILS on
# empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_hard";
  $fs = \Drupal::service("file_system");
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS);
  $manifest = [
    "src/app.ts" => [
      "file" => "assets/app-XYZ789.js",
      "src" => "src/app.ts",
      "isEntry" => true,
      "css" => ["assets/app-CSS000.css"],
    ],
  ];
  $path = $dir . "/manifest.json";
  file_put_contents($path, json_encode($manifest, JSON_PRETTY_PRINT));
  \Drupal::state()->set("vite_eval_hard_manifest", $path);
  \Drupal::state()->delete("vite_eval_hard_result");
' >/dev/null 2>&1
echo "reset: manifest fixture written (src/app.ts), state vite_eval_hard_manifest set, result cleared"
