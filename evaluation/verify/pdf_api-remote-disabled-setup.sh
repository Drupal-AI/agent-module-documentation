#!/usr/bin/env bash
# Introspection SETUP: disable remote asset loading (isRemoteEnabled=false), a non-default
# security-relevant value, so an agent can inspect and report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("isRemoteEnabled", FALSE)->save();
' >/dev/null 2>&1
echo "setup: pdf_api.dom_pdf.settings isRemoteEnabled=false"
