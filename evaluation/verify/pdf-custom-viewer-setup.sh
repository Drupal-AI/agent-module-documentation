#!/usr/bin/env bash
# Introspection SETUP: write a known custom pdf.js viewer path into the pdf module's
# `pdf.settings` config object so an inspecting agent can read it back off the live site.
# The module ships no config/install, so this object does not exist at baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf.settings")
    ->set("custom_viewer", "/themes/custom/acme/pdfjs/viewer.html")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pdf.settings custom_viewer = /themes/custom/acme/pdfjs/viewer.html"
