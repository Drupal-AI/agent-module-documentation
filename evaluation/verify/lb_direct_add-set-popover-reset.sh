#!/usr/bin/env bash
# Execution RESET: force lb_direct_add to the default DROPBUTTON display (use_label=0, label
# 'Add block'), so verify (which requires popover use_label=1 + label 'Add widget') FAILS.
# Running reset again after the task = cleanup (restores defaults). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("lb_direct_add.settings")
    ->set("use_label", 0)->set("label", "Add block")->save();
' >/dev/null 2>&1
echo "reset: lb_direct_add.settings use_label=0, label='Add block'"
