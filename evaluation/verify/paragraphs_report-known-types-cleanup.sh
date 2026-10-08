#!/usr/bin/env bash
# Introspection CLEANUP: restore empty content_types (default). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("content_types", [])->save();
' >/dev/null 2>&1
echo "cleanup: content_types restored to empty (default)"
