#!/usr/bin/env bash
# Execution RESET: remove any response_header that already outputs X-Frame-Options: DENY, so
# verify FAILS on this state (the shipped x_frame_options SAMEORIGIN entity is left alone and
# does NOT satisfy verify). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("response_header")->loadMultiple() as $e) {
    if ($e->get("name") === "X-Frame-Options" && $e->get("value") === "DENY") { $e->delete(); }
  }
' >/dev/null 2>&1
echo "reset: removed any X-Frame-Options: DENY response_header"
