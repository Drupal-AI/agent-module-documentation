#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (dpi=96, defaultFont=serif). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("dpi", 96)->set("defaultFont", "serif")->save();
' >/dev/null 2>&1
echo "cleanup: pdf_api.dom_pdf.settings dpi=96 defaultFont=serif"
