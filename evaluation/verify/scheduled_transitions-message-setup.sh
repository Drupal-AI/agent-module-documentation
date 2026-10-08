#!/usr/bin/env bash
# Introspection SETUP: put a distinctive marker in the historical-revision message template so
# the agent can read it back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $c->set("message_transition_historical", "SCHTRMARK copied revision #[scheduled-transitions:from-revision-id]")->save();
' >/dev/null 2>&1
echo "setup: message_transition_historical now begins with SCHTRMARK"
