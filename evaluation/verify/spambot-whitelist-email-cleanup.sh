#!/usr/bin/env bash
# Introspection CLEANUP: empty spambot's email whitelist back to the shipped default ([]). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("spambot.settings")->set("spambot_whitelist_email_list", [])->save();' >/dev/null 2>&1
echo "cleanup: spambot_whitelist_email_list=[]"
