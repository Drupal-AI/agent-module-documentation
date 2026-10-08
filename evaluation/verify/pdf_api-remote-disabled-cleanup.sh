#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default isRemoteEnabled=true. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("isRemoteEnabled", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: pdf_api.dom_pdf.settings isRemoteEnabled=true"
