#!/usr/bin/env bash
# Introspection SETUP: enable anonymization and set sessions retention to 86400s.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip_anon.settings");$c->set("policy",1)->set("period_sessions",86400)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ip_anon.settings policy=1 period_sessions=86400"
