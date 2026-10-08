#!/usr/bin/env bash
# Introspection SETUP: set save_pdf TRUE so the PDF is served as a download; agent reads it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("save_pdf", TRUE)->save();' >/dev/null 2>&1
echo "setup: printable.settings save_pdf = TRUE (download/attachment)"
