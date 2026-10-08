#!/usr/bin/env bash
# Introspection CLEANUP: leave ept_core_starterkit enabled (module installs are cumulative in
# this campaign; nothing to restore). Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: no-op (ept_core_starterkit left enabled)"
