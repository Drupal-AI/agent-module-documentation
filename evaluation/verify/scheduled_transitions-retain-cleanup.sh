#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for retain_processed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $c->set("retain_processed.enabled", FALSE)->set("retain_processed.duration", 2419200)
    ->set("retain_processed.link_template", "revision")->save();
' >/dev/null 2>&1
echo "cleanup: retain_processed restored to defaults (enabled:false, duration:2419200)"
