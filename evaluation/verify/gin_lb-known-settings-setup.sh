#!/usr/bin/env bash
# Introspection SETUP: snapshot the current gin_lb.settings to a state key, then write a KNOWN,
# non-default configuration the agent must read back from the live site:
#   toastify_loading=composer, save_behavior=default, hide_discard_button=FALSE,
#   hide_revert_button=TRUE, enable_preview_regions=TRUE.
# The matching cleanup restores the snapshot. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $state = \Drupal::state();
  if (!$state->get("gin_lb_eval.known_settings_backup")) {
    $state->set("gin_lb_eval.known_settings_backup", $cf->get("gin_lb.settings")->getRawData());
  }
  $cf->getEditable("gin_lb.settings")
    ->set("toastify_loading", "composer")
    ->set("enable_preview_regions", TRUE)
    ->set("hide_discard_button", FALSE)
    ->set("hide_revert_button", TRUE)
    ->set("save_behavior", "default")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gin_lb.settings toastify_loading=composer save_behavior=default hide_discard_button=FALSE"
