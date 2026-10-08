#!/usr/bin/env bash
# Execution RESET: remove any X-Robots-Tag response_header (not shipped by default), so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("response_header")->loadMultiple() as $e) {
    if ($e->get("name") === "X-Robots-Tag") { $e->delete(); }
  }
' >/dev/null 2>&1
echo "reset: removed any X-Robots-Tag response_header"
