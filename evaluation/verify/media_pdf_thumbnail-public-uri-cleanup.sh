#!/usr/bin/env bash
# Introspection CLEANUP: remove media_pdf_thumbnail.settings (baseline = config absent).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_pdf_thumbnail.settings")->delete();' >/dev/null 2>&1
echo "cleanup: media_pdf_thumbnail.settings deleted"
