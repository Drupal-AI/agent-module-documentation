#!/usr/bin/env bash
# Introspection CLEANUP: restore Config Ignore's ignore list to the shipped empty default.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("config_ignore.settings");
  $c->set("mode", "simple")->set("ignored_config_entities", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_ignore.settings ignored_config_entities reset to []"
