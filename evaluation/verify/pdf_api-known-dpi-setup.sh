#!/usr/bin/env bash
# Introspection SETUP: set a known non-default DPI (150) and defaultFont on the pdf_api
# Dompdf config so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("dpi", 150)->set("defaultFont", "DejaVu Sans")->save();
' >/dev/null 2>&1
echo "setup: pdf_api.dom_pdf.settings dpi=150 defaultFont='DejaVu Sans'"
