#!/usr/bin/env bash
# Introspection SETUP: configure lb_direct_add to render as a POPOVER menu (use_label=1) with a
# custom trigger label, so an agent can read the active display style from config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lb_direct_add.settings")
    ->set("use_label", 1)->set("label", "Add content")->save();
' >/dev/null 2>&1
echo "setup: lb_direct_add.settings use_label=1 (popover), label='Add content'"
