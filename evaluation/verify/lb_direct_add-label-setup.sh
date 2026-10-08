#!/usr/bin/env bash
# Introspection SETUP: configure lb_direct_add popover trigger label to a known value so the
# agent can read the configured label. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lb_direct_add.settings")
    ->set("use_label", 1)->set("label", "Insert block")->save();
' >/dev/null 2>&1
echo "setup: lb_direct_add.settings label='Insert block' (use_label=1)"
