#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped message_transition_historical template. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $c->set("message_transition_historical", "Scheduled transition: copied revision #[scheduled-transitions:from-revision-id] and changed from [scheduled-transitions:from-state] to [scheduled-transitions:to-state]")->save();
' >/dev/null 2>&1
echo "cleanup: message_transition_historical restored to default"
