#!/usr/bin/env bash
# Execution RESET: create the media 'document' default view display with the thumbnail using the
# plain core 'image' formatter, so the verify (which requires the PDF thumbnail formatter) FAILS
# until the agent switches it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("media","document","default");
  $d->setComponent("thumbnail", ["type" => "image", "region" => "content", "weight" => 5, "settings" => [], "label" => "hidden"])->save();
' >/dev/null 2>&1
echo "reset: media.document.default thumbnail formatter = image (core)"
