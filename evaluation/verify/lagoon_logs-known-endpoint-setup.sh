#!/usr/bin/env bash
# Introspection SETUP: set a known Logstash host/port in lagoon_logs.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'Drupal::configFactory()->getEditable("lagoon_logs.settings")->set("host","logs.probe.internal")->set("port",6514)->save();' >/dev/null 2>&1
echo "setup: lagoon_logs host=logs.probe.internal port=6514"
