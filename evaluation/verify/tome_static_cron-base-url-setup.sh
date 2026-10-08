#!/usr/bin/env bash
# Introspection SETUP: write a known base_url into tome_static_cron.settings so an inspecting
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tome_static_cron.settings")->set("base_url","https://static.example.org")->save();' >/dev/null 2>&1
echo "setup: tome_static_cron.settings base_url = https://static.example.org"
