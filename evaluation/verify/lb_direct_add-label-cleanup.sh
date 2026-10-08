#!/usr/bin/env bash
# Introspection CLEANUP: restore lb_direct_add shipped defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lb_direct_add.settings")
    ->set("use_label", 0)->set("label", "Add block")->save();
' >/dev/null 2>&1
echo "cleanup: lb_direct_add.settings reset to defaults"
