#!/usr/bin/env bash
# Execution RESET: force lb_direct_add to POPOVER mode (use_label=1, label 'Legacy'), so verify
# (which requires the default dropbutton use_label=0) FAILS. Reset again after task = cleanup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lb_direct_add.settings")
    ->set("use_label", 1)->set("label", "Legacy")->save();
' >/dev/null 2>&1
echo "reset: lb_direct_add.settings use_label=1, label='Legacy'"
