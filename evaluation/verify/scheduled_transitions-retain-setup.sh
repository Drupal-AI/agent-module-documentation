#!/usr/bin/env bash
# Introspection SETUP: set a distinctive retention duration on scheduled_transitions.settings so
# an agent can read it back. Baseline is enabled:false/duration:2419200. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $c->set("retain_processed.enabled", TRUE)->set("retain_processed.duration", 604800)->save();
' >/dev/null 2>&1
echo "setup: retain_processed.enabled=true, retain_processed.duration=604800"
