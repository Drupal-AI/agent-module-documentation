#!/usr/bin/env bash
# Introspection SETUP (smart_ip_abstract_web_service M): set a known Abstract API key so the agent
# must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_abstract_web_service.settings api_key "abstract_test_key_9f3a" -y >/dev/null 2>&1
echo "setup: smart_ip_abstract_web_service.settings:api_key = abstract_test_key_9f3a"
