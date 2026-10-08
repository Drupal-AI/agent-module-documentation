#!/usr/bin/env bash
# Execution RESET: force scss_compiler.settings to defaults (output_format compressed, plugins
# = scss only) so verify FAILS until the agent switches to expanded output and enables .less.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")
    ->set("output_format", "compressed")
    ->set("plugins", ["scss" => "scss_compiler_scssphp"])->save();
' >/dev/null 2>&1
echo "reset: scss_compiler.settings output_format=compressed, plugins={scss}"
