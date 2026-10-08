#!/usr/bin/env bash
# Introspection SETUP: configure the media 'document' default view display so its thumbnail
# field uses the Media PDF Thumbnail Image formatter, so the agent can read which formatter is
# in use. Idempotent. Baseline = the display does not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("media","document","default");
  $d->setComponent("thumbnail", ["type" => "media_pdf_thumbnail_image_field_formatter", "region" => "content", "weight" => 5, "settings" => [], "label" => "hidden"])->save();
' >/dev/null 2>&1
echo "setup: media.document.default thumbnail formatter = media_pdf_thumbnail_image_field_formatter"
