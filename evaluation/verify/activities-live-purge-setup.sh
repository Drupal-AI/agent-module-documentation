#!/usr/bin/env bash
# Introspection SETUP: configure activities time-based purge (older than 30 days) so an
# inspecting agent can read the purge policy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("activities.settings");
  $c->set("purge", ["purge_method"=>"time_based","time_value"=>30,"time_unit"=>"days","count_limit"=>10000])->save();
' >/dev/null 2>&1
echo "setup: activities.settings purge = time_based / 30 days"
