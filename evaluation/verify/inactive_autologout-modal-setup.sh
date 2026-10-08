#!/usr/bin/env bash
# Introspection SETUP: set a distinctive warning-modal title so an inspecting agent can read it
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("modal_title", "Idle timeout warning ABC")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: inactive_autologout modal_title = Idle timeout warning ABC"
