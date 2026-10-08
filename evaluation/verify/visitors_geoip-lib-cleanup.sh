#!/usr/bin/env bash
# Introspection CLEANUP: no state change (leave visitors_geoip enabled as baseline). Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: no-op (visitors_geoip left enabled)"
