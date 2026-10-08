#!/usr/bin/env bash
# Execution RESET for the "restrict to Image + Document" task: clear the media-type
# restriction back to the install baseline (empty map = all types offered) so the task
# starts from empty state and the verify FAILs until the agent builds it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_library_bulk_upload.settings")
    ->set("media_types", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media_library_bulk_upload.settings media_types cleared to empty baseline"
