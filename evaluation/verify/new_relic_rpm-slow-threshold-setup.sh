#!/usr/bin/env bash
# Introspection SETUP: enable slow-views logging and set a known odd threshold (347 ms)
# on new_relic_rpm.settings so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("new_relic_rpm.settings");
  $c->set("views_log_slow", TRUE)->set("views_log_threshold", 347)->save();
' >/dev/null 2>&1
echo "setup: new_relic_rpm.settings views_log_slow=true views_log_threshold=347"
