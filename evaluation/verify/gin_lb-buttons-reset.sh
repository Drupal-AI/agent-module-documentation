#!/usr/bin/env bash
# Execution RESET: snapshot gin_lb.settings (once), then force the OPPOSITE of the target state
# so verify FAILS on reset: hide_discard_button=TRUE, hide_revert_button=TRUE,
# save_behavior='stay'. The agent must flip all three. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $state = \Drupal::state();
  if (!$state->get("gin_lb_eval.buttons_backup")) {
    $state->set("gin_lb_eval.buttons_backup", $cf->get("gin_lb.settings")->getRawData());
  }
  $cf->getEditable("gin_lb.settings")
    ->set("hide_discard_button", TRUE)
    ->set("hide_revert_button", TRUE)
    ->set("save_behavior", "stay")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gin_lb.settings hide_discard_button=TRUE hide_revert_button=TRUE save_behavior=stay"
