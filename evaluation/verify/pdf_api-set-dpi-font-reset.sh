#!/usr/bin/env bash
# Execution RESET: force dpi and defaultFont to shipped defaults (96 / serif) so verify
# FAILS until the agent sets dpi=300 and defaultFont=sans-serif. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf_api.dom_pdf.settings")
    ->set("dpi", 96)->set("defaultFont", "serif")->save();
' >/dev/null 2>&1
echo "reset: pdf_api.dom_pdf.settings dpi=96 defaultFont=serif"
