#!/usr/bin/env bash
# Execution RESET: force isJavascriptEnabled=TRUE (shipped default) so verify FAILS until
# the agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("isJavascriptEnabled", TRUE)->save();
' >/dev/null 2>&1
echo "reset: pdf_api.dom_pdf.settings isJavascriptEnabled=true"
