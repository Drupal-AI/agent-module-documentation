#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default output_format (compressed). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")->set("output_format", "compressed")->save();
' >/dev/null 2>&1
echo "cleanup: scss_compiler.settings output_format restored to compressed"
