#!/usr/bin/env bash
# Introspection SETUP: record a known last-build URL in the tome_static.url state key so the
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sset tome_static.url 'https://static-live.example.org' >/dev/null 2>&1
echo "setup: state tome_static.url = https://static-live.example.org"
