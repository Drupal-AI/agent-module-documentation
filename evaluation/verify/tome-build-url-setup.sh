#!/usr/bin/env bash
# Introspection SETUP: record a known "last static build URL" in the tome_static.url state
# key, so the agent can read it back with 'drush sget tome_static.url'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sset tome_static.url 'https://tome-build.example.net' >/dev/null 2>&1
echo "setup: state tome_static.url = https://tome-build.example.net"
