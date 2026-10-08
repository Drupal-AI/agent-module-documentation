#!/usr/bin/env bash
# Introspection SETUP: set html_title allowed-tags to a known, non-default value so an
# inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set html_title.settings allow_html_tags '<em> <strong> <cite>' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: html_title.settings allow_html_tags = '<em> <strong> <cite>'"
