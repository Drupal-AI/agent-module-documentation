#!/usr/bin/env bash
# Introspection SETUP (device_geolocation M2): set a known Google Map API key so the agent must read
# the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset device_geolocation.settings google_map_api_key "AIzaSyDEVICEGEOtestkey" -y >/dev/null 2>&1
echo "setup: device_geolocation.settings:google_map_api_key = AIzaSyDEVICEGEOtestkey"
