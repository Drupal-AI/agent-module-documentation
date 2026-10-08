#!/usr/bin/env bash
# Introspection SETUP: configure the global pop-up as a modal dialog with a distinctive title so
# the agent can read commerce_ajax_atc.settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_ajax_atc.settings")
    ->set("pop_up_type", "modal_dialog")
    ->set("ajax_modal_title", "CAATC probe modal")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_ajax_atc.settings pop_up_type=modal_dialog title=CAATC probe modal"
