#!/usr/bin/env bash
# Introspection SETUP: store a known safe-list pattern in vendor_stream_wrapper.settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("vendor_stream_wrapper.settings")
    ->set("allowed_file_patterns", ["vswknown/dist/css/*.css"])
    ->save();
' >/dev/null 2>&1
echo "setup: vendor_stream_wrapper allowed_file_patterns = [vswknown/dist/css/*.css]"
