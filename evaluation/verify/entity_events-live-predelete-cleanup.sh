#!/usr/bin/env bash
# Introspection CLEANUP: leave entity_events enabled (site baseline). Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: entity_events left enabled (site baseline)"
