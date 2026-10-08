#!/usr/bin/env bash
# Introspection SETUP: enable anonymization and set watchdog retention to 3600s.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip_anon.settings");$c->set("policy",1)->set("period_watchdog",3600)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ip_anon.settings policy=1 period_watchdog=3600"
