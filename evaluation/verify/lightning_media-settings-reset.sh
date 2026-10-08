#!/usr/bin/env bash
# Execution RESET: restore lightning_media.settings to the shipped defaults
# (entity_embed.choose_display FALSE, revision_ui FALSE) and clear cached entity type
# definitions so media's show_revision_ui follows. Verify FAILS in this state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lightning_media.settings")
    ->set("entity_embed.choose_display", FALSE)
    ->set("revision_ui", FALSE)
    ->save();
  \Drupal::entityTypeManager()->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: lightning_media.settings back to defaults (choose_display FALSE, revision_ui FALSE)"
