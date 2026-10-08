#!/usr/bin/env bash
# Execution RESET: (re)create config_delete_parent.settings (declaring a config dependency on
# config_delete_dchild.settings) plus the child, so verify FAILS until BOTH are deleted.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_dchild.settings")->set("label","child")->save();
  \Drupal::configFactory()->getEditable("config_delete_parent.settings")
    ->set("label","parent")
    ->set("dependencies", ["config" => ["config_delete_dchild.settings"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: config_delete_parent.settings (+ dependency config_delete_dchild.settings) exist"
