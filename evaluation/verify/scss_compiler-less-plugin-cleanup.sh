#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default plugins map (scss only). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")
    ->set("plugins", ["scss" => "scss_compiler_scssphp"])->save();
' >/dev/null 2>&1
echo "cleanup: scss_compiler.settings plugins restored to {scss: scss_compiler_scssphp}"
