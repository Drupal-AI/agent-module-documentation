#!/usr/bin/env bash
# Execution RESET: remove media_pdf_thumbnail.settings so no public destination URI is set
# (verify FAILS until the agent sets it). Baseline = config absent. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_pdf_thumbnail.settings")->delete();' >/dev/null 2>&1
echo "reset: media_pdf_thumbnail.settings deleted"
