#!/usr/bin/env bash
# Introspection SETUP: place a known email on spambot's email whitelist so an inspecting agent can
# read back which email is exempt. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("spambot.settings")->set("spambot_whitelist_email_list", ["spambot_flagged@example.com"])->save();' >/dev/null 2>&1
echo "setup: spambot_whitelist_email_list=[spambot_flagged@example.com]"
