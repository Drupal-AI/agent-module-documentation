#!/usr/bin/env bash
# Execution RESET: write a Vite manifest fixture where entry src/widget.ts has an associated CSS
# file assets/widget-CSS111.css; store manifest path in state vite_eval_css_manifest and CLEAR
# output state vite_eval_css_result so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_css";
  $fs = \Drupal::service("file_system");
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS);
  $manifest = [
    "src/widget.ts" => [
      "file" => "assets/widget-JS222.js",
      "src" => "src/widget.ts",
      "isEntry" => true,
      "css" => ["assets/widget-CSS111.css"],
    ],
  ];
  $path = $dir . "/manifest.json";
  file_put_contents($path, json_encode($manifest, JSON_PRETTY_PRINT));
  \Drupal::state()->set("vite_eval_css_manifest", $path);
  \Drupal::state()->delete("vite_eval_css_result");
' >/dev/null 2>&1
echo "reset: css manifest fixture written (src/widget.ts), state vite_eval_css_manifest set, result cleared"
