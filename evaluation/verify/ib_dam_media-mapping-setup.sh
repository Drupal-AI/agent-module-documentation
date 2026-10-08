#!/usr/bin/env bash
# Introspection SETUP: map IB source type 'document' -> local media type 'video'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ib_dam_media.settings")
    ->set("media_types", [["source_type" => "document", "media_type" => "video"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ib_dam_media.settings.media_types document->video"
