#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default isJavascriptEnabled=TRUE. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("isJavascriptEnabled", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: pdf_api.dom_pdf.settings isJavascriptEnabled=true"
