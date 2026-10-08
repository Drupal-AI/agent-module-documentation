#!/usr/bin/env bash
# Execution RESET: empty spambot's IP whitelist so verify FAILS until the agent adds the IP. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("spambot.settings")->set("spambot_whitelist_ip_list", [])->save();' >/dev/null 2>&1
echo "reset: spambot_whitelist_ip_list=[]"
