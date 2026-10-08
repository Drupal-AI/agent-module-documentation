#!/usr/bin/env bash
# Execution CLEANUP: restore install defaults (no content types, watch off). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("content_types", [])->set("watch_content", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: content_types cleared, watch_content=FALSE (defaults)"
