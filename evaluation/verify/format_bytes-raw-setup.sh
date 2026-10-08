#!/usr/bin/env bash
# Introspection SETUP: store a known raw byte value in Drupal State under a namespaced key so
# an inspecting agent can read it back and report what the format_bytes filter would render.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("format_bytes_eval.raw", 5242880);' >/dev/null 2>&1
echo "setup: state format_bytes_eval.raw = 5242880 (format_bytes -> '5 MB')"
