#!/usr/bin/env bash
# Execution CLEANUP: restore addanother.settings to shipped install defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("addanother.settings");
  $c->setData([
    "default_button" => TRUE, "default_message" => TRUE,
    "default_tab" => TRUE, "default_tab_edit" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: addanother.settings restored to shipped defaults"
