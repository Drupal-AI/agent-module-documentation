#!/usr/bin/env bash
# Introspection SETUP: create config_delete_dep.settings that declares a config dependency on
# config_delete_child.settings (plus the child), so an agent can report the declared dependency
# (relevant to the 'Delete config dependencies' feature). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_child.settings")->set("label","child")->save();
  \Drupal::configFactory()->getEditable("config_delete_dep.settings")
    ->set("label","parent")
    ->set("dependencies", ["config" => ["config_delete_child.settings"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_delete_dep.settings depends on config_delete_child.settings"
