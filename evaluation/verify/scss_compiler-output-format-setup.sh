#!/usr/bin/env bash
# Introspection SETUP: set scss_compiler.settings output_format to a known value (expanded), so
# an agent can read the live compiler output style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scss_compiler.settings")->set("output_format", "expanded")->save();
' >/dev/null 2>&1
echo "setup: scss_compiler.settings output_format=expanded"
