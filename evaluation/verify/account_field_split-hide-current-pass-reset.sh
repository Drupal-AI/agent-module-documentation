#!/usr/bin/env bash
# Execution RESET for "hide the Current password field on the account form". Forces the
# account_field_split `current_pass` pseudo-field VISIBLE (weight 0, content region) so verify
# FAILS until the agent disables/hides it. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->setComponent("current_pass", ["weight" => 0, "region" => "content"]);
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: current_pass forced visible (content region) — must be hidden by the agent"
