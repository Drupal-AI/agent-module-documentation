#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (output_format compressed, plugins scss only). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")
    ->set("output_format", "compressed")
    ->set("plugins", ["scss" => "scss_compiler_scssphp"])->save();
' >/dev/null 2>&1
echo "cleanup: scss_compiler.settings restored to defaults"
