#!/usr/bin/env bash
# Introspection SETUP: set the Imagick toolkit's imagick.config jpeg_quality to a known,
# non-default value (42) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagick.config")->set("jpeg_quality", 42)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imagick.config jpeg_quality=42"
