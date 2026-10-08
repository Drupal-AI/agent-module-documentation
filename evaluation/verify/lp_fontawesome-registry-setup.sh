#!/usr/bin/env bash
# Introspection SETUP: lp_fontawesome has no per-site config, so this only rebuilds caches so the
# agent can inspect the live asset-library registry (library.discovery) for the lp_fontawesome
# libraries. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches rebuilt; lp_fontawesome libraries discoverable via library.discovery"
