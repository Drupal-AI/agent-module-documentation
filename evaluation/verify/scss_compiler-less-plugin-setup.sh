#!/usr/bin/env bash
# Introspection SETUP: map the 'less' extension to the LessPHP compiler in scss_compiler.settings
# so an agent can read which compiler handles .less. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")
    ->set("plugins", ["scss" => "scss_compiler_scssphp", "less" => "scss_compiler_lessphp"])->save();
' >/dev/null 2>&1
echo "setup: scss_compiler.settings plugins.less=scss_compiler_lessphp"
