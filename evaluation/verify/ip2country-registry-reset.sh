#!/usr/bin/env bash
# Execution RESET: restore rir/update_interval to defaults (all / 604800) so verify FAILS until
# the agent sets apnic + 2 weeks. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");$c->set("rir","all")->set("update_interval",604800)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ip2country.settings rir=all update_interval=604800"
