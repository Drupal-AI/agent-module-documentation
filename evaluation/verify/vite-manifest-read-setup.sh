#!/usr/bin/env bash
# Introspection SETUP: write a real Vite manifest.json into the public files dir and store its
# absolute path in Drupal state key vite_eval_manifest_path, so the agent can use the vite
# Manifest class to report the built file (and CSS) for a source entry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_fixture";
  $fs = \Drupal::service("file_system");
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS);
  $manifest = [
    "src/main.ts" => [
      "file" => "assets/main-ABC123.js",
      "src" => "src/main.ts",
      "isEntry" => true,
      "css" => ["assets/main-DEF456.css"],
    ],
  ];
  $path = $dir . "/manifest.json";
  file_put_contents($path, json_encode($manifest, JSON_PRETTY_PRINT));
  \Drupal::state()->set("vite_eval_manifest_path", $path);
' >/dev/null 2>&1
echo "setup: manifest written; absolute path in state vite_eval_manifest_path (entry src/main.ts)"
