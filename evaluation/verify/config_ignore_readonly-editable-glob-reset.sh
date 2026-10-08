#!/usr/bin/env bash
# Execution RESET: clear Config Ignore's ignore list so the system.* glob is NOT whitelisted
# (verify FAILS until the agent adds a pattern matching system.rss). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("config_ignore.settings");
  $c->set("mode", "simple")->set("ignored_config_entities", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: config_ignore.settings ignored_config_entities = []"
