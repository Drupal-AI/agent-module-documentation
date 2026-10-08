#!/usr/bin/env bash
# Introspection SETUP (smart_ip_ipinfodb_web_service M): set a known API version (2) so the agent
# must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip_ipinfodb_web_service.settings")->set("version", 2)->save();' >/dev/null 2>&1
echo "setup: smart_ip_ipinfodb_web_service.settings:version = 2"
