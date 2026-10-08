#!/usr/bin/env bash
# Introspection SETUP: set a known public destination URI in media_pdf_thumbnail.settings so
# the agent can read it back. Baseline = config absent. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_pdf_thumbnail.settings")->set("destination_uri_public","public://mpt-known")->save();' >/dev/null 2>&1
echo "setup: media_pdf_thumbnail.settings destination_uri_public=public://mpt-known"
